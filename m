Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE3B66CEE4
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 19:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjAPSeV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 13:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjAPSdv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 13:33:51 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11DC360A7;
        Mon, 16 Jan 2023 10:21:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nwg/O87nYUVAwI1fyEAiaGhGB3pOmcypWfi6gHu5df+9Pgr+hcMfuFs8iUENXVTm4L/jWM4UEcEE8CUGIuDR44jwgiScK9lR5+D4T9T2JxRxjQvxOJkdXU0qVnMq2Zn5D92Czo9e7bpGU2QIGDrHhz131WRzoFlvZ3qsSziS/hkNUQLHEwoADRvtHJko7hPNvCV8cwIVl7vguXpAbzYGhdZeETm94lJePIKDPMDXLgHNP2n3Yp7R5/troaNq6+N/31pq0+DX6+6Lvz5XMpcHP+ftw6y+IbBR6/rUjafeFuyiyDPuppbOCx5/4rpDC/2l6+I583tgpmQ3vuxhuVlycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiFCHU3Ups4wOED447gQH8SQKDuwsMXbxT0g+2gp7tY=;
 b=eZ6kxfgw2vyIwEC7iWb9cF3d01CmGfBwpHnyCPypIsPk9yB62uMuq1uupa2d1DqPt6TQ5BSjko0HSyw8UgZkz/9+1rKPIRhtQfZXW50SStjeVFRNufrKA+bOtPRfFJcXZLuRQ/cbUBgE46zHgaJ70deoZEJGAWGVCWx3KSy2hGD8SMw+vJiZByYJaFuX7ZIWjBQFdn/6ykKtTXIcbPHCNjL0MewykyJjvxaDH+tWWIJNRKXj0Amy7ZDtFDTMvv5GBT65e65R+f0JTV/yJ7H9hhDP0Xbo7uS4fVDnkf5UqD90Nybh+4sXusOiAH7cgOpnVnAtVjZ+9WXD+PZFK+3R8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiFCHU3Ups4wOED447gQH8SQKDuwsMXbxT0g+2gp7tY=;
 b=C/PkFYDAdqXwDN/eRAjWyMRhEoGNY6CknMI2sU8m3UU6Fw3ZPBdNm7Z+g37oU895k1Werc6alzzQFECRWshDj6r1fZkceKwqC26HbCMc7Ul86lUcnUmA+To8S/FB5Hi+I9/sa6sMDxkFg92huwmMM6fKZSmT3PSZgAOiIfXy3L0ltVkmU16YkvKy6EywIXtiUZPg6Uh3Yj+Z132Zzq6oghCX6QfEZ2Ou1IsiFlaCmmP8aPis1ENHfQ0WTFVInyA7SGOr6gq2PaGKviwVgooj3qBWtPmyOv35uDzLbC/BtDdOjifBDJkE263qrWm11ywbFuxebemeN228wqJiqQDEDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 18:21:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 18:21:41 +0000
Date:   Mon, 16 Jan 2023 14:21:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        zyjzyj2000@gmail.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH for-next v3 3/7] RDMA/rxe: Cleanup code for responder
 Atomic operations
Message-ID: <Y8WVtJLzjGXMr7no@nvidia.com>
References: <cover.1671772917.git.matsuda-daisuke@fujitsu.com>
 <d95bb1de314ec3cf5a93e0c5730900d67521e08d.1671772917.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95bb1de314ec3cf5a93e0c5730900d67521e08d.1671772917.git.matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BL0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:2d::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 326e629d-743a-4197-3fad-08daf7ee83d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rO3eP4Pr6NrTgKobQCpEg8xH6TuboNQUgGctWHIkWyJsuU182SuPWyivtLZlboHc7JgPqdVbLzlUSeQg8pM6UI3K47x9llkR3G5rbfcoFPZO8N7QXSbtqfsWCapxHDEpKsoT9I3CV/wcAnB3GIJotRM2g/IZU7toMhQuVziHJNpJEMUK53ATR1PkdE+ontYDoWqz0e8CsCsNgflte/ajsWyFJ8HoxCg5+XeO6sf+qwCN3gXhys+6eE/NDyPeIoF5ytutJlrZbhmyn5b+OZ6GNBJuqilH6v4mpryYuXOsPvqmDB3x2gdNzbh9DHZ8shNH14AnKfM0pQp9Umk/tJfC+16fjz6EXn6LcKAm6InJQsy8kZsUOUQCpxatp0tJP37PUG+88Fko4vDo87o4ZNZRckMwJDme2IafecbH3K3caTqM9YqUVmOisIsAesb+gP/u6LiQb4M0BvQkgUhtSb1ZKGj85atlGHlKn3A2bN9mR/t59TEWXl15zmIVTHq/GEcP1glbIk9LaJjNm7X3LNOSvpvhOefIFuVV7DicMLeWrIcUnSW9yvq3qx3TqAwNyM+vt2vXpt3sH6NNpwh3b6cSFdj4cMNlWYQ8ozMZrmRiCh6MjgQQDfeKuTmNTKtebEU/le5qnTabVkOE+WxYmlAkEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199015)(86362001)(36756003)(6916009)(6512007)(186003)(4326008)(8676002)(66556008)(66946007)(2616005)(26005)(66476007)(41300700001)(6506007)(316002)(83380400001)(478600001)(6486002)(38100700002)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWhdOf/kWwGxUYV+7D8l1cVQ0NGvSrpglC51ZVkbxAiW/QKYL+BTCovWOc4T?=
 =?us-ascii?Q?VFLZhAHjrOrpGKKvi66ff1cxFN3DAiKqnVfs/H4TyZwt4MTS+bIFffNj4+76?=
 =?us-ascii?Q?Udvqe12w0cLlDcYGo0qT0WDZ8/rtcQOQ9VjmdJ02p8C8NG2AbgY7gooSNw7n?=
 =?us-ascii?Q?lKUzFp1eA4ActdhoDNFv1FLbPVZ2KAtqPu8YIeAbUzxl4Nt/SEWjvwJQP/Qh?=
 =?us-ascii?Q?zuwVuDnl3Qp96ePcU8hvn1u+dMi5JyFO9MLoy/kz5DAEwoOkNCgSGuc0Uqyw?=
 =?us-ascii?Q?3Qvyy8C40PYAwbpJW0Ls8BxNYbIT9e+ku9f5OWlwYfBgVZY9gDL6lDFLll/m?=
 =?us-ascii?Q?tNTq0Uteq4bPJLQ36lcFVt0V8R8OxvSIn5YS2M6wVYBF4zgn0BD/1tbPoEME?=
 =?us-ascii?Q?khFBSg0P+4YWMQ+DDaCnWwyuNFtDOhXRsRglLzRFjzAIlziiT6c2gmhYrLAL?=
 =?us-ascii?Q?vpBifM9XHmh72J202s1uqOUEMOjiN93WSHIbKBlF6IABeJ9ZrxgiD+RJIojG?=
 =?us-ascii?Q?0wtA456/8s8lGiz6Y+tME74JIaEfvZyEmMsaDYyXIKN7ADxXTK5++21cYAwn?=
 =?us-ascii?Q?mke/0F/JOaBiRM11BqQdL30J3jzAIjjFPIHe9I3WKNX2af76WsCKnoJNd1TQ?=
 =?us-ascii?Q?wIWruYSOH+wCczT7j9H6c7iB3+6ADDyie9ZX/66OmFcmdv26eQ0P1asJj2jc?=
 =?us-ascii?Q?HiVVaa4yAjnpUEaSKOPrvT1utpiKfYSSjY4Nz2LW7Q5uSLIETllFJ0FAXRI1?=
 =?us-ascii?Q?p97lnAg5/91+96WutnP7ck0p4VbuIQD+qDT105lAwgfkaFDC7Dt7GlLoa6Ho?=
 =?us-ascii?Q?wn7XVPZ+S5YsjOCwpjsTY4sZvdT0IXz8APd1CXBwtYgFKbUDPQ+4nT3xgmMp?=
 =?us-ascii?Q?K6uxhKOYVdVMV3e+9DVKENwOTcoA5f5aR0uBzhwuncrtS34Be+WTs8akSJ91?=
 =?us-ascii?Q?Ndi/q1mF8R2nqu0vFODmN2U0WrC4uZOVlLhklOkOWqjIygc0CYDn8cuAvYIo?=
 =?us-ascii?Q?4fNqdZPAi1HTnWskAKgr20IyGz/zmT7/RC3qhB24EirhJrYzSmWJHEJGX5Li?=
 =?us-ascii?Q?5ysMHG3mi/0Bt6xeXvvUX/h12MrbShoqoccoR8/YJwACdoNo0UK80kVeOeam?=
 =?us-ascii?Q?LDspv+J1iVN6f4odOsQqHDFP4P40QoQ7cOXT/PJnVq3nJ7ClS8EHUBYUpDli?=
 =?us-ascii?Q?CHyxM0PxClABGG25pPmaLiuXdmTxq6ydiQ7w2/ceOZ0oBi70DTgucFwK6mg8?=
 =?us-ascii?Q?a2JsArq4rKt2VgFquvHmJw0klBDodaRQU8iyeJZjj57k0EjMa5Khk8um71oH?=
 =?us-ascii?Q?A/aUBg6iLkhSvDp9WhIBEg+wRn4J7kRA+rtUFp1ZQhQTPoKjyS6qCSu4Hbwr?=
 =?us-ascii?Q?C0Sx6Cy3yx8Vanz6WDaEbfLtynuHow0uMV/ihkLD2BoJmId4TjE025CoLF9C?=
 =?us-ascii?Q?Kvg+6Simgj6yfZC3IQWNq3X7xrUH3OB4AVDhmVvCcjV6/qIeiQmlibtho8ON?=
 =?us-ascii?Q?7yRKDv6K7OP0i6a829GQDWtDeWQ4TtVfVEEgwmcPrk71QYSX8o0cpAwEtXG/?=
 =?us-ascii?Q?Z2Ak6KvzWTPT7eOzcvalyjEihk10rlsIg7gslwzj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326e629d-743a-4197-3fad-08daf7ee83d0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 18:21:41.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5zFqb7j+srx1JzIXfppDxeSBywNXlbCdz5+iHn85kyu/QpR4a8BNLkmXU0zvwIq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 23, 2022 at 03:51:54PM +0900, Daisuke Matsuda wrote:
> @@ -733,60 +734,83 @@ static enum resp_states process_flush(struct rxe_qp *qp,
>  /* Guarantee atomicity of atomic operations at the machine level. */
>  static DEFINE_SPINLOCK(atomic_ops_lock);
>  
> -static enum resp_states atomic_reply(struct rxe_qp *qp,
> -					 struct rxe_pkt_info *pkt)
> +enum resp_states rxe_process_atomic(struct rxe_qp *qp,
> +				    struct rxe_pkt_info *pkt, u64 *vaddr)
>  {
> -	u64 *vaddr;
>  	enum resp_states ret;
> -	struct rxe_mr *mr = qp->resp.mr;
>  	struct resp_res *res = qp->resp.res;
>  	u64 value;
>  
> -	if (!res) {
> -		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_MASK);
> -		qp->resp.res = res;
> +	/* check vaddr is 8 bytes aligned. */
> +	if (!vaddr || (uintptr_t)vaddr & 7) {
> +		ret = RESPST_ERR_MISALIGNED_ATOMIC;
> +		goto out;
>  	}
>  
> -	if (!res->replay) {
> -		if (mr->state != RXE_MR_STATE_VALID) {
> -			ret = RESPST_ERR_RKEY_VIOLATION;
> -			goto out;
> -		}
> +	spin_lock(&atomic_ops_lock);
> +	res->atomic.orig_val = value = *vaddr;
>  
> -		vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
> -					sizeof(u64));

I think you need to properly fix the lifetime problem with iova_to_vaddr
function, not hack around it like this.

iova_to_vaddr should be able to return an IOVA for ODP just fine - the
reason it can't is the same bug it has with normal MRs, the mapping
can just change under the feet and there is no protective locking.

If you are going to follow the same ODP design as mlx5 then
fundamentally all ODP does to the MR is add a not-present bit and
allow the MR pages to churn rapidly.

Make the MR safe to changes in the page references against races and
ODP will work just fine.

This will be easier on top of Bob's xarray patch, please check what he
has there and test it.

Thanks,
Jason
