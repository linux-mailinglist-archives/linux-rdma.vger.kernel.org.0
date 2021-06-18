Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0254D3AD015
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 18:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhFRQMv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 12:12:51 -0400
Received: from mail-sn1anam02on2054.outbound.protection.outlook.com ([40.107.96.54]:45518
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232825AbhFRQMu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Jun 2021 12:12:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnLxU4cFlgfrZkWar/PsxhuNlM4B0OB7s5t4To/VhsesVijqIEJ2yVkGVPUfywwyFqKRcGbWzI/lhiL6PRl4cWiITi4QLmiTArF6kN3DRAVhk7dgyH2CdvIX1+Tpnr3TGFXd2Ar0pLJpOrrzU0XVt6IskKut7I0HXyrPRer3HfgNkBUjZHX/FLbRHVw2a2ux35X6g51tFt/yzAILDJbnt1ogLEw8xaCUFLCgtp/lDVxqQA1Q37P5ZlFxMcNKkzUmPBZxfemp8cHZ5PaNki0QobtuzA4kqTaQ6eX4d3h0ez0CIlKvCO/jwtNQexXb+hJA+koISCij0P61fzpeN5Ggiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey59kpfysGsCYe8ceajoftQjgYt4pgO54RIdLR3G27I=;
 b=jey32rrS5kDwPP4lYMZBmHJSSbfa4u7Jp2hu/5fT4+STiIqOTgVnv55YQCfBqaiIqJzXvvtFWiZhE7dIsXnTe0ZA/iyfSnBWo+dZInb/D2zfbwXgCgGJ753O1D7uLZxKVIaHNIy3R4dSK9iiO6HoThIWHA8h5qdX9uhrHrGNTi3guESl9cCx1ShXis5CzpC3x9SIliWnI3mE4oooN4qzccN2Xrl5U/JX0UAYdHfwxD5mVrDfSo7C9chuEig+2GvsUzgLwgVxKBDO96vrgnfFx1lolef/JVwkVMAQljOI88bqWe/0s10nzdn/UMjBWoeV25HR73FZB2LzrRDjDX5pwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey59kpfysGsCYe8ceajoftQjgYt4pgO54RIdLR3G27I=;
 b=hOZMgw2mvxN/5xpr/lY8+iD/mN+x5cZnjRxlA5voq8DopDZTCtU5VU8O7lSvIsghvbwpIqf3JJOAvroyG9X50QsYHdC93zEnHULgUuTcVcXVpvb4pHpgbMSIIfx+jvl6fC1NzbQI5ONJ9VTLWA43xrtHAG2OtLqiHvfPScHOPee6mwRjd0HlOcy2E8SRg6MQIWBhmfrXzcigQShLlrsjl0/xvVEc4YqAlNW43Rw9YnvZ0/j2/0xKrmydU8YOCKhsllfBJkJt/2IqcsbEi2RbRrOMG2gUK8XyrudLryjmXDOSpW7FLilrF6oEGwEIuBSTWJaGY4PpapyQ7v1qY3GS8w==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 16:10:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 16:10:40 +0000
Date:   Fri, 18 Jun 2021 13:10:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     hhh ching <chenglang7@gmail.com>
Cc:     Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next 1/8] RDMA/hns: Fix sparse warnings about
 hr_reg_write()
Message-ID: <20210618161038.GH1002214@nvidia.com>
References: <1624010765-1029-1-git-send-email-liweihang@huawei.com>
 <1624010765-1029-2-git-send-email-liweihang@huawei.com>
 <20210618120159.GC1002214@nvidia.com>
 <CAEc5TmJTfaSqPgk7CWgD1R9Oqddkg7XEJSHJF0A=8EFJtXcYLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEc5TmJTfaSqPgk7CWgD1R9Oqddkg7XEJSHJF0A=8EFJtXcYLQ@mail.gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:208:134::40) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:208:134::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Fri, 18 Jun 2021 16:10:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1luH4o-008Zmy-Ne; Fri, 18 Jun 2021 13:10:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec2b642-c160-48e2-e6cc-08d932739dc5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5287EC497BF965AD6A22CBF9C20D9@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxIF4LdZEtccqEwDSrUFOKsSClpwdLlim+Vkq4lE9WDZQ/48iqA3ykHxzRmj6O1c45+v7NKyUgqZ3rKnGpFMDXQqAnW4SiGRT+ZX32BzKR5nL9828gdq6Eg0s3tigei3XP4DyuQ3NzINMpUD1UCcAe1bmUahw7zWCAvVAOFFNMlM5O1O5vUmnUaM/hZ0f77Y1iyudVjckJRB6orxFam0ZxmQXvpJt6uCyKQ5+lGWGD2/DLgHnVGW05288XfEyTUB45MgvhVuK/G11End9EKKMRu7bgKDobSC8WbjtlgI9SMRwwVOSrVSsH11RWGI+pxPhAE+8DrnrXgnGieuFpdI7qInbmZoG8Mp6+R8fz9uyqv4HowJQbhw77NpZ8GKbY2LRyJiKvd9mS1NIr48J7bMtE6T1G6j5Txyh0siYKtYVR5HSxxxi7b97ul9JvZWIcLb2mvjitf3Jk6CI64skG84n/DUg6XHeCXXVce5p+WbFg81TUOWbbsIFh/6Auky/R/URtLtRedRo3+7SskN0FF9yw/5TyH5oaMVH2iLdGeXI1KXBWyNwhbdVWOjuIPDqbHl1I4+82y/t9fJf/UNVNg8GDYXcQNszbLe4S/H8Uodwpk6y8THurnVCcXVeHDMeVhLMcVygC9HK1EsTwaWgZDWzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(2616005)(186003)(83380400001)(478600001)(66946007)(66476007)(4326008)(8676002)(1076003)(36756003)(316002)(66556008)(86362001)(33656002)(9746002)(9786002)(6916009)(26005)(426003)(38100700002)(5660300002)(8936002)(2906002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTB2UkNOU1E0UVBSS1psYmZwc1lsZzU4ZmRLb2wzTmxGOXlqTXBuN1NFMlZU?=
 =?utf-8?B?N1FORDlLMFIrM1NnSDRUazlmUlRNbloxQ3EvbDY1ZWxTT1pybDlpOGxUT1I4?=
 =?utf-8?B?R3g4L0JnSEpVVVpSaWVlUXpxMjJ3ZjNRczRBZkp2KzBEOUU0VXRjeDJiblJv?=
 =?utf-8?B?aFVoZzllUUpYUG1vcW03N0pWTmhzTHhBaTliYmxaOUF6QTI4bkpueDJJQ1l3?=
 =?utf-8?B?engyb0lVbEdFTTZkWlJkZmcvMndMUkJleFN2NHUyU1VzRnVtUXcrQUVTVWtY?=
 =?utf-8?B?VHNSMURLaEFxTEYwVWRFRHZCZkRRZDFLMHN4cUYrUGVaSWJEalQzQVJhT3M3?=
 =?utf-8?B?UHE1cm9nbzhxWHhmZ2pQcWdSRTZhVUM1RFRnSXFwaUcvakYrU01ZNTFYRkJ4?=
 =?utf-8?B?S0pRQ2ErUWpFTTlpZTQyZFZwN2IrcC9heWJmNTJreHFiZGtLdHdYYzViSVZy?=
 =?utf-8?B?YjZvU2RsMm1KbUZxcUZES1ljUHhEQnYwV3lPK3VWZVppMHd2bWFSUnNPSmRk?=
 =?utf-8?B?emc5RlNuT0FJdDRuUU9RM3BUMHFxSDRpZEZSN3dPZyt5bmhqMHdGUWlCV0k0?=
 =?utf-8?B?TDFoL1hLRDVqb0pQWnJGWHgwSE1ZTUhRV0VyM0lnUzB0OGcrdUJmZTRub2xv?=
 =?utf-8?B?SGx3b1VFMVRBTENyazRCaHFoZnQrZitldHQ3SXBITDVmem01YytJNE4zNktI?=
 =?utf-8?B?MitYL3pacTVTK0RoSzdObzA1MUVVZkVBRWxrWFMxOFMzRXAraSt0ZnJSWmpm?=
 =?utf-8?B?Y2RVLy9nR3k3Y2ZzQ21keUx5QUFuWVFkZHlnYUZhaEltV0FNWmxDanZMMFBi?=
 =?utf-8?B?eE8vSytDaEdvK0pCZmxLWHJWaWtra0dZL1pNck5qaXcxckpTRlljNHV6VWU4?=
 =?utf-8?B?bW1xSlVYeEpwMFRsQzJpWkFTN0dOWkdWenkyRWxNTUpwdDhMclNGeWdLSC9G?=
 =?utf-8?B?Um9iUXBPNnBlajM0Qlg2U1ZhbTdrdW5JWTRBV21PWnJiNEIyS1ZzY1pnMWMr?=
 =?utf-8?B?QXNjbHFPbFBhaExxTUJxbUpDRFZrc3JmbExrK3J1dFZGNlV4TlFCV1dSbmg5?=
 =?utf-8?B?QTQ1VUxpTEhBMk1sdHY4M093NzdmczJxWGQ1cjd6ZUxNL1VxQU9oTStrV0da?=
 =?utf-8?B?NzBNc0dzSDRSeGpUeXlLWDg4aFZoV2g3MHV1MXFwSEJSWGNOM01XMjEwbHF4?=
 =?utf-8?B?SDFCK1Y4aWhyRGEvQk8vbGlOYkFrY0Zoa1BXZkVRV0VLcmNlTDZnd29wYjh3?=
 =?utf-8?B?cWtDRmVkanlnYjdZTGZQS0dqRE1Gbm13TjRzUTdGMWRQVTlsanVCMTgxRUk3?=
 =?utf-8?B?RVRDNDdmZm9KR1BKWDZjYWhvQitQeG1mQXR5TUV4azByU3BnWWtwWVJ6SUtD?=
 =?utf-8?B?dG1IUWpBbjJiRFA1VEc2RFJadDZuUnBpTnNoalBjUzZNcG51U3BZanhJNkZu?=
 =?utf-8?B?WVJPQ0Y0QWtqUzBYeEp3UnRkSEJTdjFEQWlIZmRyQTEzR1RlN1oxT05QaldK?=
 =?utf-8?B?QzBjU1V6ZDNraEdrSHU3aWpQVmMzQWZvR2dPYnY2cGY5LzQrcjhiaUFHTGN5?=
 =?utf-8?B?UHZXTGNXTmErTkhkVmhSUStHa0FqbHI0SHZCYTlaU2szbWx3QStwelJIOVNW?=
 =?utf-8?B?R1haNGhPQk5kV240VExVOWxkL29IRHBnQmNSdjUyNXg4VzF1S2pWaVZqM3RK?=
 =?utf-8?B?cFR6RHpCeE4wMTFiNEQwVFZoUW80SzhuZzlxVWYwek5scGFsNjJFV0lNL28r?=
 =?utf-8?Q?TVFswEjV4VHQeN+TgV1P3v3f5R4ymEd6SrFTP9W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec2b642-c160-48e2-e6cc-08d932739dc5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 16:10:40.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Smv7OCPZ2LyNh7cds5wSLnVfptPD0j+Qp6pSm/seomb261S0HFRwAhOHHT6OHyC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 18, 2021 at 11:22:46PM +0800, hhh ching wrote:
> Jason Gunthorpe <jgg@nvidia.com> 于2021年6月18日周五 下午8:49写道：
> >
> > On Fri, Jun 18, 2021 at 06:05:58PM +0800, Weihang Li wrote:
> > > Fix complains from sparse about "dubious: x & !y" when calling
> > > hr_reg_write(ctx, field, !!val) by using "val ? 1 : 0" instead of "!!val".
> > >
> > > Fixes: dc504774408b ("RDMA/hns: Use new interface to set MPT related fields")
> > > Fixes: 495c24808ce7 ("RDMA/hns: Add XRC subtype in QPC and XRC type in SRQC")
> > > Fixes: 782832f25404 ("RDMA/hns: Simplify the function config_eqc()")
> > > Signed-off-by: Weihang Li <liweihang@huawei.com>
> > >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > > index fbc45b9..6452ccc 100644
> > > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > > @@ -3013,15 +3013,15 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
> > >       hr_reg_enable(mpt_entry, MPT_L_INV_EN);
> > >
> > >       hr_reg_write(mpt_entry, MPT_BIND_EN,
> > > -                  !!(mr->access & IB_ACCESS_MW_BIND));
> > > +                  mr->access & IB_ACCESS_MW_BIND ? 1 : 0);
> >
> > Err, I'm still confused where the sparse warning is coming from
> 
> Hi, Jason, i found some code in sparse/evaluate.c:
> const unsigned left_not = expr->left->type == EXPR_PREOP &&
> expr->left->op == '!';
> const unsigned right_not = expr->right->type == EXPR_PREOP &&
> expr->right->op == '!';
> if ((op == '&' || op == '|') && (left_not || right_not))
>         warning(expr->pos, "dubious: %sx %c %sy",
> 
> I guess the "dubious" is,  if somebody use "&" or "|",  maybe he want
> to bitwise operate a number instead of a bool.

Oh I see, yes, that does many some sense actually

> > A hr_reg_write_bool() would be cleaner?

Which makes me further think this is the right direction

Jason
