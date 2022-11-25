Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45535638BF2
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Nov 2022 15:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKYOQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Nov 2022 09:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKYOQe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Nov 2022 09:16:34 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357822124E;
        Fri, 25 Nov 2022 06:16:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbIlLRYSs0SkVHalzQ3pA40B7P+JiQwqLYsYuBxTAKU8qAl8u9bX4/M+J+Mog7gy2+Inmk3YLAm8dVUTqPTu0hraTPq5GhjDILeAEcZftVqbKEmYY2bKoLHZ7uwGqSYryFRKew/2SZvv8R5u3ZkTyNLUXmArfrIgIdFhCkZ+vybVFs3WpiFUUAGurhXzb/TljesRM58n+dAk80lupfKR/IRZtw8UHUxpeqH3gXgzrY/db//hYH4nq7H5jPERrMEFVcFTcolSkcuPSg4UksoGsKNYRxMzfCmZSzXh5uhjL0NZpfebAKPV+IkVWtauZjShFsMhYTXvJgqT4cLaeFn2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2pqurmQZal9URHNgEH4EuSfn+EFNIVy9iCboG/NsJQ=;
 b=HE0LyLVlCbEW5ejrGYDOpLwJMy4TpOY+edM8y3RLwqzuBJtJTdELuUV+vT0szo8FM08BheUR/uoNcQSlne7SYbMATs5hPRixLR66kow38li3UjaTkxYrIStIDX0UOGiimreDcWANUgvohrWO/sKka0Qks8uMgcJsxlgqnfpR3r8nI6dFS6biCx9hqI1WWdQ92bnJIWk2e7rGVdgu84GSbLjFYfjRAYq1LSpEWJHeqGLIibN3q714mCptNmZsuqvYYacsTG9qFWAkYxcXLv+RpCA5sTCe2zCd7VqW7i5JY5+zwqNLbqcK6aGwM+qqMYVTSTRvuEGaNQQbn8UdPlb13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2pqurmQZal9URHNgEH4EuSfn+EFNIVy9iCboG/NsJQ=;
 b=U9vMRpXVIkdp/dwPAeFj8dGsVfLNDC8GHKzJ9QL0qoXTn+xwdm2R6ZH6WGNnfYGYeOmc3xZlx5LgKVYMK+tK9YkjjSlIU7QvQfnVK9ZzkOy9MRlEEjRMwXaF0MiNShrmp/xzGAddJexFRN2D7h7LPZ/T6xHoZnfTxnbv9niD9DESGP7K1OzNJTmwqetmZgjKeGLslf2b4iDIID2xDunVEzZ/8YWbS8qG3eEIE03Qjep/mWoQfeU1T2PEq3cHf2XVoRuSSTHQQwrFiGgrGvdIUeyan8QM+C96C2rtFGXQGIBLXL/YgoMVVtJPD08xZiuXw0kuMihiREv6SaXOr4Y+hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 14:16:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 14:16:31 +0000
Date:   Fri, 25 Nov 2022 10:16:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [for-next PATCH v6 09/10] RDMA/cm: Make QP FLUSHABLE
Message-ID: <Y4DOPjDKM64ryuP3@nvidia.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
 <20221116081951.32750-10-lizhijian@fujitsu.com>
 <Y3ziLoRuXFIOpnnl@nvidia.com>
 <9cf2a1c5-2334-dee8-8374-63453e23c5a3@fujitsu.com>
 <Y3+sb3RZkEO3ISpW@nvidia.com>
 <a3a10e6e-c75e-853b-06d3-ce2f67424afc@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a10e6e-c75e-853b-06d3-ce2f67424afc@fujitsu.com>
X-ClientProxiedBy: MN2PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:208:23c::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: f41ae1dd-65ad-4db0-d674-08daceefa678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3yjnyxY2ulHQrc5+6EfZkAJKzED3zdZgOJEPmARTBw4FMftuBpy9JQhfhZUkvMA+OJgHXMoFBAefOpVU0c0v7hR3zQY8p6WuMo1qXa9MuVT3LXtLi0+RYb8dBnwa42GhHoOPhAczGvVK6iRKFr7p/uTE54bMG8vQsPw9zubzJdfob3PXd77k1L8EQxq12AfYhnmGvpauHuoW3PmMrP/pgJrs0wwNjb9v1AEyCS2fAL/b7pyVuyKeQ330ZOjBtR0DiQ3t4a8c8ytL8EbuWAJfoxJgRuixNDeg3DvDSGWcqMNe52unN1LFRC/7b3qJFS1qpmvxGucFJM2aqGH1PfVxbTXS29okl4NhfMt/iMYaU04yHn1AgqSJQVhSmiQn1oVLGooJUyB6NhglQddtEwaIZZwB4zwprj4Hb529zu26qqar9KJUeIGHnmzItHVgC/ZLjvmZq9YOrJUSgSfMZzh7KRENDIdCm+PEr80L6gmc2YjhE93IkHkepkxFzYeNaaAXoEA3YzY7VsTG+zJ5RNIin7OQA/TFp8L6C4e9z7rvSPbTj39ZekBdfYyIopwGMVFKkn4cI98kUDL3A1QdaSLAIBZj64xds0QLIVshhmnbwjZXC330gbl9U3F26BbR5PA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(38100700002)(83380400001)(2906002)(6916009)(86362001)(186003)(8936002)(7416002)(26005)(5660300002)(36756003)(6512007)(2616005)(66556008)(66476007)(478600001)(66946007)(41300700001)(54906003)(316002)(4326008)(6486002)(8676002)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Y3S80sN3YuqN4zQ9rKm4ViQsOc1VzIiiwg+OBOrRtCBPXMzuWDHQ2hR3Nr6?=
 =?us-ascii?Q?jL+AYfa312S0Lo1JJUmzy0FA19F8sAIUx6Hsn7cH1Ui/IpJrf3ri8YHtIvJN?=
 =?us-ascii?Q?G+N36t4NcXRV6MdpcWKbjuZ7upySf5zEexWT/n//RgliG+PICfoNU17d/iq/?=
 =?us-ascii?Q?zd9KTAEnT1D+I8/ozdNvmQNiEMMjI1TzyaQEVJPN7xhaa1tin+MA8QIbdQIA?=
 =?us-ascii?Q?3FaWswX7jkETFoE/HfAGt5KQfZj207/T8lVLAMYkdeGLLHH1hxNo+0HX1qKX?=
 =?us-ascii?Q?NRJA87cMlhJFN+rBbBhiTmVuD3i0HXIqo5VsJnIrJkw6hM+qME4zs4+B9fTr?=
 =?us-ascii?Q?5Zs1/PdBovXGvS129jg9G/oBESqRPEDlIdALIx3GE8BMa7s6Gtd4jb7OH5Gg?=
 =?us-ascii?Q?xWJBZBS4d70NBsJlw9e1aup6RHqYnc399BlJspQ8XukdD7entJ5lp63RnYqi?=
 =?us-ascii?Q?s+onZWT3EaEups5528en04LwV4/MTSe9/RlRwuzZ8TkPWVK83LPnZomUGgQu?=
 =?us-ascii?Q?PTqS5610sIN0E696r9wvaLPSog9o+b1aEoZS7IfO+tGHi1/go4tZ0WpgaiN4?=
 =?us-ascii?Q?dauqeRHB9Cm9SNWX++X7KNniMAgxpGMFJyGpHejWIGSmSBECy9DKKuIyAig8?=
 =?us-ascii?Q?LXUM31hXKXWaqpdMOyP1m+9J8h2x/6UfKYSt5jbyiXhuumM/3eXk9Ys0W+mj?=
 =?us-ascii?Q?WiBWxUVairVhbxKsOIEKPyYr1w+bVoQXs/nYGqHLIcGtgWT69qMQYxR8WMAU?=
 =?us-ascii?Q?wqf2qdlVxQ9f2sv25LaZwjOjekqff+vih1A+0P9UcHuxBAy2Jzrcu/Gjijlq?=
 =?us-ascii?Q?h7jKyg8IZh9RVgHBhW1UBYI7h4MD45wYUI/GT62DszK1eyxa7M2zRNOWXprl?=
 =?us-ascii?Q?C02wdCScbIph1CKatLYITlnqtacQ1D9GQC1S5Cx7S/SYJTxlBqXgdxHPavxn?=
 =?us-ascii?Q?SaVd0xyi2GDW33lhpLbAVuInqCIKM47O3+W03qOzbabbK6VyNd2TWN/hm5pm?=
 =?us-ascii?Q?6wP9Ruy3HR+1iphCZyjWnPMChjADyqYX/Ia3F5kefDKX27hJODzG9MfeubLx?=
 =?us-ascii?Q?w91VlPernSPx0FUEmxEoeoVkLsXWe7P+AyfY5AU+mhhBWGx53GbhiE/ROJZP?=
 =?us-ascii?Q?+GF9vWStK+xEDdY/qpaTnRzIGC2YJXjBsxoigpFjWf8v6wvBKx9q4RjriO7x?=
 =?us-ascii?Q?RQG6qR+MOJ7mxAAh4BEckKtzA1e7lZETrGYfpvqga0+IPp8oQKHh3aM6ggG9?=
 =?us-ascii?Q?D81xiMJxE10j8mnB5YtfE17/uE694DuGr/Uzwm8lDn1oPJI8VQdKQqzMVWhO?=
 =?us-ascii?Q?YQHnUV+NvV3S/g4pMMjLRZ9yYaoWMXbzk8ojyO6S9JR+hM4gu8JU4Qh3qvEv?=
 =?us-ascii?Q?T6emeQEyMwxcXwlYUSCh8I1uGsrlOwFdouMoy1u+YxTh10By3Lf+LoF/ZRRJ?=
 =?us-ascii?Q?xpU0p8G1+S4JfT8JX3/eRWSM/YIx+ayyMabopZEYYLnh0DipHnx1vjwdx12j?=
 =?us-ascii?Q?pmusUYdgWY6Hbj4rMhpAPFnQyddG/7K62KPdKLMDRtLu8hJT5011RShozne7?=
 =?us-ascii?Q?mEZqQxcpOOIUNhs6yJQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41ae1dd-65ad-4db0-d674-08daceefa678
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 14:16:31.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTay3tW9DeGZ0mZvV7cS+W0/o7D8BpX13DZkr0B7V2db0QnZaA5M8V3xqLzl/2w9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 25, 2022 at 02:22:24AM +0000, lizhijian@fujitsu.com wrote:
> 
> 
> On 25/11/2022 01:39, Jason Gunthorpe wrote:
> > On Wed, Nov 23, 2022 at 06:07:37AM +0000, lizhijian@fujitsu.com wrote:
> >>
> >>
> >> On 22/11/2022 22:52, Jason Gunthorpe wrote:
> >>> On Wed, Nov 16, 2022 at 04:19:50PM +0800, Li Zhijian wrote:
> >>>> It enables flushable access flag for qp
> >>>>
> >>>> Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> >>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >>>> ---
> >>>> V5: new patch, inspired by Bob
> >>>> ---
> >>>>    drivers/infiniband/core/cm.c | 3 ++-
> >>>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> >>>> index 1f9938a2c475..58837aac980b 100644
> >>>> --- a/drivers/infiniband/core/cm.c
> >>>> +++ b/drivers/infiniband/core/cm.c
> >>>> @@ -4096,7 +4096,8 @@ static int cm_init_qp_init_attr(struct cm_id_private *cm_id_priv,
> >>>>    		qp_attr->qp_access_flags = IB_ACCESS_REMOTE_WRITE;
> >>>>    		if (cm_id_priv->responder_resources)
> >>>>    			qp_attr->qp_access_flags |= IB_ACCESS_REMOTE_READ |
> >>>> -						    IB_ACCESS_REMOTE_ATOMIC;
> >>>> +						    IB_ACCESS_REMOTE_ATOMIC |
> >>>> +						    IB_ACCESS_FLUSHABLE;
> >>>
> >>> What is the point of this? Nothing checks IB_ACCESS_FLUSHABLE ?
> >>
> >> Previous, responder of RXE will check qp_access_flags in check_op_valid():
> >>    256 static enum resp_states check_op_valid(struct rxe_qp *qp,
> >>
> >>    257                                        struct rxe_pkt_info *pkt)
> >>
> >>    258 {
> >>
> >>    259         switch (qp_type(qp)) {
> >>
> >>    260         case IB_QPT_RC:
> >>
> >>    261                 if (((pkt->mask & RXE_READ_MASK) &&
> >>
> >>    262                      !(qp->attr.qp_access_flags &
> >> IB_ACCESS_REMOTE_READ)) ||
> >>   
> >>
> >>    263                     ((pkt->mask & RXE_WRITE_MASK) &&
> >>
> >>    264                      !(qp->attr.qp_access_flags &
> >> IB_ACCESS_REMOTE_WRITE)) ||
> >>    265                     ((pkt->mask & RXE_ATOMIC_MASK) &&
> >>
> >>    266                      !(qp->attr.qp_access_flags &
> >> IB_ACCESS_REMOTE_ATOMIC))) {
> >>    267                         return RESPST_ERR_UNSUPPORTED_OPCODE;
> >>
> >>    268                 }
> >>
> >> based on this, additional IB_FLUSH_PERSISTENT and IB_ACCESS_FLUSH_GLOBAL
> >> were added in patch7 since V5 suggested by Bob.
> >> Because of this change, QP should become FLUSHABLE correspondingly.
> > 
> > But nothing ever reads IB_ACCESS_FLUSHABLE, so why is it added?
> 
> include/rdma/ib_verbs.h:
> +	IB_ACCESS_FLUSH_GLOBAL = IB_UVERBS_ACCESS_FLUSH_GLOBAL,
> +	IB_ACCESS_FLUSH_PERSISTENT = IB_UVERBS_ACCESS_FLUSH_PERSISTENT,
> +	IB_ACCESS_FLUSHABLE = IB_ACCESS_FLUSH_GLOBAL |
> +			      IB_ACCESS_FLUSH_PERSISTENT,
> 
> IB_ACCESS_FLUSHABLE is a wrapper of IB_ACCESS_FLUSH_GLOBAL | 
> IB_ACCESS_FLUSH_PERSISTENT. With this wrapper, i will write one less 
> line of code :)
> 
> I'm fine to expand it in next version.

OIC, that is why it escaped grep

But this is back to my original question - why is it OK to do this
here in CMA? Shouldn't this cause other drivers to refuse to create
the QP because they don't support the flag?

Jason

> 
> > 
> > Jason
