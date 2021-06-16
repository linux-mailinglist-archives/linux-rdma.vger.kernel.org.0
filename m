Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E873AA474
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 21:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhFPTm2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 15:42:28 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:13313
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232635AbhFPTmX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 15:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSfIHXin3jfHeAuXqbgTHXTAjpiHxK2CSL+oAaQIbtrIK4ZZkTsHOYPi2MDbB0zm9T9Zt7ilVX6CXAlzZ0AWoZrq0+2LMqGTVC4Km5H+XIlLrLrQUIuLkJ2e2qETT5zXK5b7x2hIMsfym7ccD1WreEAJoViorKoZ/BXKF/9zssbX5jS++bGQBTk426GlyQgpDalG50AJfu2Op5Rt9WueATwxtO+dHS5eKd5PKg9y4VnWgRYL8JsORXG6CipizCxvPUkRQ0O2JY8hJaTw35D5NCsHF9y3+iCjLhFdyht9WaJkIf0eNI/jxGu/v9se5i+XNsfY5inMxc35207i93LNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWCMlb0ZDlLqxU9k9diEQGb+Lmc5jeuqH6rRcxlUSG4=;
 b=TxuUgPSqAipqH9mzwfpRc5YSzUYODDUsTVvJ+xZMoXSInYnghQiE+IHPmh0mXebn1f0cKK2R8jOFZa7+dAoOLXbjF7K77CnbPArLz3Nmz1cVboSqjF7Ldqmscs/J6khz74WHVS1y2/feQjp+wt7Qc/MGEh9caIQnZ8uQPDV0QvANV69FSnRxa8cDWqctfW+A4s4BZJf+kJ8MO3PPIvWEC3hxAXYc6Cz0UkYQju/1b4bsZWsOzHC9FA3C0F18cgWJYUuREMlTzumQH+HspjpaH+A/gVrKyyKzlg5WAalXNWGR/g6wx8/emPcu5zbMPR9qWBLLvNjBk/vVEPZI2w3GVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWCMlb0ZDlLqxU9k9diEQGb+Lmc5jeuqH6rRcxlUSG4=;
 b=C41LQ1O4ynLAi7iXV1CS/ITu7gUgXfEcHYBG8OM4HIL4OO3TUVPYTsr2mx7iVd2q/yVnEwhoPuf0OdTmly3g6WwOmw4Wi8HBIuW5Vuw74a7KRz1/tZZ6rq+LoJIvw+voRE13r864BHDKave6s8BiW1Ss7m9q9YZyX1OesH7V6/ppM6VQwpo/Knc0JwmLgXM6NDzEg9UQCkNGf5WCr/V8IyHefv9ipazZNk0TvnuHoFsNpogSaZxMd8V9WqPrWyOt6y/yVYTGzj+OdIvOUqApp2drBvVz+HVHb3XzkRZkO0RpUwmwQncJlOv0oU0pDK4X+6PTCrrlOBpEhFtbhuQVHA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Wed, 16 Jun 2021 19:40:15 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::18b7:5b87:86c1:afdb]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::18b7:5b87:86c1:afdb%8]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 19:40:15 +0000
Date:   Wed, 16 Jun 2021 16:40:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Lang Cheng <chenglang@huawei.com>
Subject: Re: [PATCH RESEND v2 for-next 1/7] RDMA/hns: Fix potential compile
 warnings on hr_reg_write()
Message-ID: <20210616194012.GA1844581@nvidia.com>
References: <1622624265-44796-1-git-send-email-liweihang@huawei.com>
 <1622624265-44796-2-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622624265-44796-2-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:208:23d::12) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR06CA0007.namprd06.prod.outlook.com (2603:10b6:208:23d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Wed, 16 Jun 2021 19:40:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ltbOW-007lCH-TK; Wed, 16 Jun 2021 16:40:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb65150b-80d9-40ca-f874-08d930fe900c
X-MS-TrafficTypeDiagnostic: DM8PR12MB5464:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54641BC8E32EE6F2118FFBBEC20F9@DM8PR12MB5464.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Kco7CJSDkZA4ZlCmq1lQAh1vwCAuO/iJV4HS755d5oH5sCRHk34F0KcvvdBgFECEPJUa5F4aGJ5suCKEn3/5zvirpis/cFH4XkMxMfxgU+v8OPgQkrvd+lKI5LoqMLshDUNxCJU1Tt3RbXYkIK8DQnAuTjlmJER48YT39bfNMfH0nNOh2qg8TiylWDEWi0XivL4MOOGeytUUy3Je6gLaldGKSRc/z9m0EW5PkXBnMW+fZvi1861Pbtpkv8UG+fpiuqAkRKRc82pFRhfGCTgR3w/QhzlT3Mjv9Ek/lY8gOh8nLvfIDqGeUd8qYQXT//1DUYmq6x0yX03voLKeYMHfu7R7UWRQhTjPaVqUvgGmKj6zPe2zqFZlBM6FzvOAMgHsmgYGy0udLElGC6z0yVqbLUOpW4D3hjzNPfwCJLmdt/Z7IlMnnw55xQF5qZ83EPzNKDBXbHEE5vgP/TjLcFECsFv48T3haOrz0Sx2GD9nlBLZn1fXTHwz69aGRzAkYfvVEuusGpxuYZDg0y+j5eWMYieVJVxPiSDMY58IwF63bW625lQRsExj6QbRnfsrQf6fVtR1uM0iRoj7Tzqup4I8AO3sSuEqKk1Ig+INHzxGE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(9746002)(86362001)(9786002)(8936002)(5660300002)(4744005)(2906002)(1076003)(186003)(66476007)(66556008)(66946007)(316002)(26005)(8676002)(4326008)(33656002)(36756003)(6916009)(83380400001)(38100700002)(478600001)(426003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?klubT80fBB1UmriWzw/388kiGsT1f6eiuU8r1UHboxjIsWpR6qfT3swJgMYD?=
 =?us-ascii?Q?9ZjkWcy4S21x65cm0ndIbrltWz8PrOksuhrOruyySW1tBhXB2i9+UIYSj5Zz?=
 =?us-ascii?Q?qnIS8N3RaMEYijmub3stuU8cNQAmysw7d0a/13BwkqZCIlJUZt+laml/3lku?=
 =?us-ascii?Q?Jn6Sjt7BUJTHNHfqYbib3yaOATB0O1xrez8cBeejmYT/W1b9cEfgJlOgCwVN?=
 =?us-ascii?Q?Z5F0mNCdGSQ2RLsmG9wBxMQg36sGurRnJSUozbAOjKux5mow/8tpvPboNqhN?=
 =?us-ascii?Q?6OS0oIvJukgc2821V5X0xjb7p/e+saZkObFIOiwyBMcD/m4gRTgpzHRkoiwV?=
 =?us-ascii?Q?EZVQE63LuAyi2zqUDQxx2MmJlfpq5VPZbB50lltt1TsYB++KOHGEXOT0P5ar?=
 =?us-ascii?Q?JOCES6VaOnVfml6ykrEH/k6NkpA0z3ztJYGME7U7jP7hnWuo6ApzrEDL9ddw?=
 =?us-ascii?Q?TNkPs0Cby1IVeqJbdUdS2/EiUHqdMSrD9rwJDSrBpj6VpA7YqJdT77MMwmA9?=
 =?us-ascii?Q?msMdXDzXDJR0oJhvJj28d4AgmEUV6zILJk6Op/ou47N/4oc1BgnzsR20INqz?=
 =?us-ascii?Q?dTiIgK/UXEYUAUCmWlZEVBXtGzDfyXsKPMgrSspqVK2YplgF/9yha4mSD8qV?=
 =?us-ascii?Q?kNnm1t2Gzt59R5jzoQ2ybsQHXxJqTsMHIlG3jKm2eKkuemxskIqsIQrhD2O+?=
 =?us-ascii?Q?bcRYNy/gE2x51o2SduB9+LEMRT3wz5yclRnkxR2grwpPmHy6Y7PsgofWskRv?=
 =?us-ascii?Q?GEBuCAfGJDDSIWWmgIn/6lbh0LSIDq1g6+x/JAWrDwUsao/CkoSaE4JWZjvo?=
 =?us-ascii?Q?p7/J4ULJiPFbsH0Gw/8u2Zqxa2WYjp2s19jKBMhA0fmW2pb8THktiRFD6+1Y?=
 =?us-ascii?Q?b88aqO/9SHHbD8idX8HyDrfrqRKPLI87kdZmOiutnMO8upS8QMZIjAagTqWi?=
 =?us-ascii?Q?aN3jICFK5AtvTjd5KJSP8o+AqKwPr77ntyrWVLHWkpU7bEhhY5L5CeznEC8q?=
 =?us-ascii?Q?ui+gWIQrS4uI+/k+n/49wGRr5Pn0w+07dybMQ9K+jH6BrNrFIgVFjU1PzR1l?=
 =?us-ascii?Q?qcfW5OTpzWoNTdNSs8VU2fIpSyq6r6+8nzxJXiCz0jr244N1eh8FZLOqyGCR?=
 =?us-ascii?Q?hv7OUebc7US52qeYqZEYBQ4UbYFU5EIF+pOWgDeujWtBvyfrWIzK/mdDHyOS?=
 =?us-ascii?Q?20pFlwU35ImrY2e46ELqyCByEKstYPCrETzVp9gYFV631zsCjHqjkLRVA+S+?=
 =?us-ascii?Q?uvQAx9QdNU0Ka7wMnBYuZzFXgU3anqK1+3KPPuibJ2ynWuS5VOhrP3ZdMMjp?=
 =?us-ascii?Q?Hu6dPubj/aTC1+qw365qjnSB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb65150b-80d9-40ca-f874-08d930fe900c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:40:15.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCd+aWgHUKZdq3kaWwCRqbsGC1PGti+UAm+evYFR0vsOEKkryBkgz0FTcoaT7vKi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 02, 2021 at 04:57:39PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> GCC may reports an running time assert error when a value calculated from
> ib_mtu_enum_to_int() is using as 'val' in FIELD_PREDP:
> 
> include/linux/compiler_types.h:328:38: error: call to
> '__compiletime_assert_1524' declared with attribute error: FIELD_PREP:
> value too large for the field

Huh? This warning looks reliable to me, you should not suppress it
like this.

> But actually this error will still exists even if the driver can ensure
> that ib_mtu_enum_to_int() returns a legal value. So add a mask in
> hr_reg_write() to avoid above warning.

I think you need to have an if that ib_mtu_enum_to_int() is not
negative, that should satisfy the CFA?

Jason
