Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ACA51B443
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 02:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiEEAEU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 20:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383401AbiEEABS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 20:01:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E156B98;
        Wed,  4 May 2022 16:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8sSVvS24/76Q4Jh8NWT85pF3rMaDWUHMYtXkxX7kOszUbzaYsaWmYlBFimx538p2JlcmxJo3m8d5+5nvIy3nGW2P9v1VlKEcQJ+O9pgQXka2kBNnHIu3s7XVjX1r/QdRUUH0j+OJhEW0R/lHdb4fr62EMfI6dnt4Rp+A+cCp6hcztrFaOIbnydwJe7bCONcgv7rVOxUzit5zMIaN/gy9tZAwg+9WNk90+EMsffKD93qZWzq+DULFyKTHJYwJVruqV2elHfL+/UaOMFo5CWpEmZNP4Q+Tx9sF73rsa0jRgh/k7gvq1fIFlQ+hCtb89nnqza4QZDTlOYatkrDH3jdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhUL3zRn6YfbTb9ROEnuLEIlEEsTIrXOEWmJc83Lkig=;
 b=hT4yK/N9Cr/Irl8JQKRcrJbQd+p9TDHx1M4tWM7Hq5R8T9L+pC7PXfuBowzBxHK1qQ+B7M3qLqYh5xlhO0wpXo+RAIDNb4E8U6ImcjGX/YANcGQZh5lNvoR1tUayElNjPeYrMc0QDPgm++f3YTUkUBBHW8CWqsKnWnggqRQY182xGSO/28lxxF+cWAaD2YtkXwmmTFmVyZXdugb+orOuozSWzzMrpNooPGm9Z1sQv9OpIO8BqyoKeKqBf9lqRuW2nllycA/PzPZLP1ZIUcJbTbjhg1Ti2pWrP956Sp+LatYzFZHc8g8sOkMPcuNi61L+lUyrg19Ek/b32omFARPlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhUL3zRn6YfbTb9ROEnuLEIlEEsTIrXOEWmJc83Lkig=;
 b=Z7CE8+2rtuYKRFF2hA5a/JoHp75YyLs6vIlQZW/EOrVrK17CHoaL9850w1+uNSOBBBpp23HPicvuH2WtRgDwsTrNK+4VHYKxkfrXJ0s5UVUWz5SVxmBELnag2rntMafsQ0P4Zkapl3BZK8Xie8pILe7i2OLJG1VGqPuTRTq6XkVXP4p5Y/itsMkyOITR9/n09OIDt+Jc9mG6YuUV7E9hd+wgcXwPWi3kk7sHKmZRjcW8miGq6jEVDGuUk0WQslX08gWJBtJi35ZJqlE28sNHOusauhzkUQINtFaZH+BjYM5GBiMT6eaeOle9gV+ZeOoGWZOM/81IVx6Wqy6kytSW6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by CH2PR12MB4940.namprd12.prod.outlook.com (2603:10b6:610:65::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 23:57:40 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::a090:8b53:715c:a961]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::a090:8b53:715c:a961%5]) with mapi id 15.20.5206.026; Wed, 4 May 2022
 23:57:40 +0000
Date:   Wed, 4 May 2022 20:57:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        "open list:HISILICON ROCE DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhengkui_guo@outlook.com
Subject: Re: [PATCH linux-next] RDMA/hns: fix returnvar.cocci warning
Message-ID: <20220504235738.GA197080@nvidia.com>
References: <20220426070858.9098-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426070858.9098-1-guozhengkui@vivo.com>
X-ClientProxiedBy: MN2PR15CA0064.namprd15.prod.outlook.com
 (2603:10b6:208:237::33) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab8b71f7-4911-4e59-20ac-08da2e29df06
X-MS-TrafficTypeDiagnostic: CH2PR12MB4940:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB49401CD4E0707F8A191AE983C2C39@CH2PR12MB4940.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLUmWa0NOfFqQ6BxLhU+bqyOTcvtbke2B3CXBhqa7juvzJ0nsm/l5TXf78ly0JhzCa0/KVqNNg+HwUMiV/IKVesmfvFPaw1c7QGvcIx6M9Hp2OfJlu22MMg47akrUo9CNbmSbjyqu8h0bYOu5WyMtYbmop+qnk2ZKvxa88HGy1L8YMTHFrChCUuo6aA9D5GwUGtavex/PJsMBfUjX+4BzYKPAiGjxlBfhj6p26W/Y2ORH4pz6TZaZWiiJucHFGGTPPzUMZmFQbs3i/6wV53Ont6bVh0IcYH6e14pXARklo4NYDxjcSrSRFzOmoDm83QPwI0Pkr+ebhZAK1d8hhy/MFJ/LIJ49vPF0EBgoQ5zhIXDLCfzET3m1GOgkxXqTZKqTHWk5XmckVjIHiVhICp+S/JdVNHFoaC4nph/6agXG3TQTTjLOxPZETQoNwLxGUjXPQJsIaMR+LqPATAnUgD9kn9QWskszYBjkXo9j2P33Asv9j5/Jpb+jSlKRalhyzAQLHIbSS+XyG0eQ5q6YA0eZbHqcOwAitbEbR4PyYxW5gNGcblMd48v/uGrjGAj1lwJIPWSlIC+/thXUpOK9aSIpM7f/E+qYYhSYbs7IZ+7UIV7PcSKYy8E8J3xJUWBA1A+8fZ/eVhRpDQw3tnlZzehaOUd++Dg+KxgecE53cyQSs9s0ycOeXgWnThZCnDLXq2q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(2906002)(508600001)(83380400001)(6486002)(5660300002)(4744005)(86362001)(36756003)(26005)(33656002)(6512007)(186003)(1076003)(38100700002)(6916009)(316002)(2616005)(54906003)(66946007)(6506007)(66556008)(66476007)(4326008)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LsQC/hw+M8RJbtqacnNPKnWTAXftmqGhQZYXkrrh34u1IMrlrLsAo+qud2R?=
 =?us-ascii?Q?2UF3kZ0u6DQ1RTslFnA19C/KzRppTjKo6365u02jAdgjH+FBtji7zMo0SMpe?=
 =?us-ascii?Q?VxLw2hFI9oOav1Xzv/hOb0xbedp1W3mJpWx80fU5+f0hTSh7LIhuz9V9QuCa?=
 =?us-ascii?Q?/GpfiiMjDR4Vyzs1sbxk/HeDGyMPlY3d7OpzVMjEq0Oi3XyPDFA8EoNc7Wns?=
 =?us-ascii?Q?wbbioCnu7s5AfVZlyEubh/FmayVdDC5nLSvBoGleUS9vxp3q17nehVLjQSUf?=
 =?us-ascii?Q?zIIdmBYWNnL3VyIU+W/eXVQks9LKJ3CaPDEl38FiVLWGFwh0JebKGu1RRGc/?=
 =?us-ascii?Q?a5/1vabXwIQR5sWAiydHPJKVXUXvXyCVAM9S3epi1BGWNNNSgqhb+XlfsoWO?=
 =?us-ascii?Q?kU2XDxceMgbrBoob5v6w62KE/JDVFP3x5r0RLHAufhyNEkH9Qd3GFXGM7FKM?=
 =?us-ascii?Q?MKfh3YTmm6vqIyPetoLooyN4q3cmpucVD99LB8YtfjIt2/mOPhDiLXQA/K9x?=
 =?us-ascii?Q?CXRTko0DyDMiA4Xf0R+NDctkNZs+2z/QJ4R7xRFzwobhemXG5UkK7tmjUz+y?=
 =?us-ascii?Q?iQbHmHW6K2LMqNgq8UXqIG3bptPfBVh6gtHPFTEqmsa7aSC+AilTfwD3V6Zj?=
 =?us-ascii?Q?EISOl8CH6pxDVstZn/G8fFmF2etQfldGRe6EJs3Z7V0CL5THla5Ge5h/joLy?=
 =?us-ascii?Q?Od4TBkAOMOtcRR/upABB+G6v0Y78kS6ZGXZ6tyz21LXfaBLjtEc2Xuch9w0x?=
 =?us-ascii?Q?GD20lXsCQxwOjWNszTdy9pst2oqTSjSbGRtg1ByIt1i2QltVmL8Mf9RXCe0s?=
 =?us-ascii?Q?CZ3xv13RqVo3cRojV517USBW/YHpa47ljLuQHgjH3TPgGhxaNfuHnLQ9VmVk?=
 =?us-ascii?Q?L7l7GoRTythcCiN8HsNLoCDnNWXOQwOspblrYW0JU/9MxVqV7XY5O78H1fIL?=
 =?us-ascii?Q?NWWEn8CPK5Q9nQEApE39ojzy3aGhzmu8WpIN4XMA/OFwXRCCToTF30TALLeZ?=
 =?us-ascii?Q?Eqz5SU8afmqa37HmKNpsKcl/zi6dZtKyYNjn8WmPuy/1h9dQKzojIQkNE0Oq?=
 =?us-ascii?Q?tjXkBLNhhC8CIAMAYarvNzYtppoC6F5WDEJzp20KDCIgsUx087WN/U3qnPAr?=
 =?us-ascii?Q?lRignXPEDsIDIVbMO1o6kVLHsidKH3fW/wLEVWTNVS5ogiwm9Hyn1kmfBa5j?=
 =?us-ascii?Q?tXGQXiMviwhigiLqEnPkVOa6aYKg0hzhSa4vRUYL8PZO/WOHO5xDb7KvGN2W?=
 =?us-ascii?Q?N1KJS1Svbe6EPHQTon+K4UQONX3ZTP+RXuE20fcq+IvEAKdJlk7SbCFka+AD?=
 =?us-ascii?Q?idEVVX1R8ouDnUhkwixeiTKXRwFMwMRg+lloB6FL0Zl6NfgxnGyboiN1SbfQ?=
 =?us-ascii?Q?7irPJKJZUpl5+rzgTkDADoYr5sRFNj9CXnMzhrlBydGKsIwJh9IJTRIG4A87?=
 =?us-ascii?Q?N7rRRN7F78mCFeXIaIPOd0mYPAR/KynzILd4io53i++rXBcdVaVuRYVJml3T?=
 =?us-ascii?Q?/yQBZM9GkviwLIhWxSe7pGxgjDgtA8GUqthEfuXL9i8sLiB7ucV3OaxIEEF1?=
 =?us-ascii?Q?NOnJpNxSbSid8TNcss1B6iSE8FIR/fr/Jj1UTYpplDWvXEwB4twxyJc7jUea?=
 =?us-ascii?Q?A25QGpqR8iF0bN6TtVVZmPVyGmXWOEGS64BIUm1tYemqMU1zWkfdurNHlO8v?=
 =?us-ascii?Q?3FT6a2EYYz2q90nIBgiFap0meg8zHCbkJpaqi+G4Vo0IITZfpihoNCQbuyHf?=
 =?us-ascii?Q?r9HkG13/Cg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8b71f7-4911-4e59-20ac-08da2e29df06
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 23:57:40.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xh7/jcG+NqLac/WX41YD5ql5xDv0Fy/uuZ1Vucyo4AcxsjjodsYQk+CDpYx7lJOt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4940
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 26, 2022 at 03:08:58PM +0800, Guo Zhengkui wrote:
> Fix the following coccicheck warning:
> drivers/infiniband/hw/hns/hns_roce_mr.c:343:5-8: Unneeded variable: "ret".
> Return "0" on line 351.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
