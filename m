Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3651FCA1
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 14:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiEIMZQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 08:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiEIMZP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 08:25:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B64F25BA7A
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 05:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAPX6nLbbfERNbwgNOAxNpf+otfedY32gzSPY1oGxq6mafDylMq7wpiPfsSuuvQW7KcS/EBAKUPdP5FjjFxKJgVRityNd6BFXfOGKjvILrNWistKbcy1xAd38u4POnKSR7mIv5vmeneUWgs1sPu4dEivqfpQuI5kVi2LN3mNTt/5nfBEDXDIXRKWE79U5bNU/7JAM/0RI6q+yfdogOoQVovb5AP/k0u4VOzm5rch+LRGzdkWxsvWzI4qAoH210HjTG2PKQPoEwpYmnKiqas0m6L1oJ4ZoQv+jgBJyU5brj0OeGIId2m9VHGR/I41SRm0XYoyDY9Vch815qOq7QediQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfNxsNu8P+Np0Mi8Wx9xlbCdMVRJ8o2/E8hIbLErA9A=;
 b=PAvrzjtg35QHKSTDRF+ker3qS4tN8XcB2y0AGbCBlMh2dYo1RfZpW84mq/4SpFLVHmG+cI5TLC2u+nPY/rqGlM0hCQjwLcykUFyvPd7Y7mu/bOeFa7YwoDiUTqyyPjBOuCO/Kk+L+NoFWACPaAWZ/SBTxcuGv/e9CdvK7FQ1iG4crs60Zy37P2u2KvdRh+TYTiTRhiuJJuCr/e141G0N3u9gM1k18x7gZ1XCjiDJNGjA5xGWzZ6OJLdrwdd8ea8BKrPrvpaYVaZ5tsPzZtM2bZKKfSmR9kBA4oviiIcUIjhRwUjqR93bBD5WCTHmNCvi5vPJ+Nu9mbKh/jaWK+5lfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfNxsNu8P+Np0Mi8Wx9xlbCdMVRJ8o2/E8hIbLErA9A=;
 b=hZXbuks4R15oaN0ykcyNKNuHGq8ljxhVWCHj5g6XQFWDxQyHmrs32SBEvsHBQkc7IYclxcdieQ2ZyReS/kxy4qvRn/i+Iw/u3fKtICxz6/jumzGWoquW+ZgF0UI9ZN4mrGRzLxDqzfLYfnNGHi7cEYdXuNkTv7DDCpkLptTIx9RtlGo/r566+0ZRlD57oirOYiDcM5UJOFh1cykZIACiWvTYmdiVhCmo2cScqoY7SjPDKQyybXDv0HnGQ/tBzOY84AMaOuLyl8I4ciGZ01Z8o3TiQB6KJrOZNpq69swOCKjRmOO8u3981B1Sgw/cMayqeIfyqDC1YyhZSfCNfQHrEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Mon, 9 May
 2022 12:21:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 12:21:19 +0000
Date:   Mon, 9 May 2022 09:21:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v14 08/10] RDMA/rxe: Stop lookup of partially
 built objects
Message-ID: <20220509122118.GA844594@nvidia.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220421014042.26985-9-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421014042.26985-9-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:208:32e::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab72a83-7093-41b7-5602-08da31b66c4d
X-MS-TrafficTypeDiagnostic: DS7PR12MB6358:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB63583B31D853083B7699F880C2C69@DS7PR12MB6358.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8Y5W9PkwGNLHbp9VJu82MTvhKMeWskZi2CgoMO5bGx/Lv45ns5ke6X4QW90LNUni1kI1CX5NlQhqS0b7lNTR3FuYVemhjQL04rMwxa7SF2P0u5hp9xnuwaUng5s5aJOZsVzumhEMS5XLuvZWeaHmgkabZjX14pv7zYDfpv39+8RsZMUNQFV8sSO8b23kVTb4kTjyx7JlYnSfD3mJEyAcyBqKoSqpNDwoPPfAMlvZHisqF+VjxGd2MmAqpzwpkWnVn0q44XJ504Jg/rNQ6y/M0RJFm47aoAp6kpQYfngGauh1KIBGNEdoPe5g7quUNrLH9x8zyFcESwaURUkjywoYFqxd8BYSFUohSaqatc6v1uQzA+95mHoQ9D/GaQfKrLOfB8eILZ/y3wPa8lVpcgkDK2w61ZCtGY5iaJ6pnFKgrD8f8ucQkaDF0wfB3Soelh0dfw+KcDAvFPWRxsbFjfphvc9cspPNixSTvZ985hhFFpkfRE0Bwzn8sQc62wn0ePk7eCVnEoidn4AFzudHx0qEcOaWULZ1hTUVyLdM8T+Bt8wDNapXukqtrV83OV2KxucB9lLgffTENloK7PxyaWc9Gh3ZdW4f/G9w+Jb4KzFWVvClzZoFRKpEV/WfnjdnuQ0T/lxTTPNpe0JjAncxc17LHzYhzqGh7slk+9MYPQX6THhHrt7QGWz1MVluy8lqnUCiE3Z7tCbeOfyZvjrZJWtLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(2906002)(83380400001)(6486002)(66476007)(36756003)(6506007)(8936002)(316002)(6916009)(8676002)(66556008)(66946007)(4326008)(2616005)(186003)(1076003)(26005)(6512007)(33656002)(38100700002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PA1vn7158CiJbsY7JRhsJwwwxFeW3meUHiU6IL5wfZVp5eIN6bcvTeujPS3o?=
 =?us-ascii?Q?e+xoc9Dzt+qMf+k1SWafNass1smrDP0ELjRauvObIScTmqHwpQ/4uTWnaNMv?=
 =?us-ascii?Q?CXrNymVavSkWUQw8Ip4yv/sN11+tSmR5yXi+kqcVGrwNGdN1vuD+L32ksrRr?=
 =?us-ascii?Q?ONu5MMLkkq4mWyTjHQR5u1XM2u9sgT6qFKZEoNHbCKkxEaZQKLvaoUii+9Bv?=
 =?us-ascii?Q?QQKxkoyX3ZqrgjinuKv68oQPJ79JyETMJNugXkFdZbKli73OApcASsv4SDhI?=
 =?us-ascii?Q?HWtiuDfW77AFqCInhcgUmTA03GCz2EvPqHhYFz2XyFNkLpU2Q0GkzpYl8vba?=
 =?us-ascii?Q?m0d7oxCm+85NnzHTG3E/aF8L4LcVN1gIXnZV9VUfKKppFlcEtRkcjNAoDofi?=
 =?us-ascii?Q?trJl46zNzYQwyboVlYo4orm6SbDYH7G22pOr6N4VdiMkIeKBuA+fUySPWf/s?=
 =?us-ascii?Q?h5U5yMkkqR0B3RunwsuQM/OTuicPD6ftQRGPeenLz+B5e9RaCchSLbQXkEmP?=
 =?us-ascii?Q?ETyzeVXuE7OZQg2T+Req39qKfthdSsi96UfVP06dAWA+Z1MfEqt05v+ddqjB?=
 =?us-ascii?Q?/BVVnyYN0ZyKzKZYYae5FyJKYpufOxLNpikGelNhvm7bif8RcFMJ28v+1nwi?=
 =?us-ascii?Q?e/Mf5u0A+kqRcUCnGP3N1iR14rezwT1VjsqANuo/Nr2cl9CbVOVKECEPKjQH?=
 =?us-ascii?Q?TFrP6e2s4k6u7UEgYVCY1JkCKVjrB73GdtwzBXow7sk+Enat+wVsw/H2fCLs?=
 =?us-ascii?Q?LngE4WFLrGVOmdpG9syIVZZMGaBVA1lVKEGzR/U5VdidaM7kZ2SQk4x2NZCs?=
 =?us-ascii?Q?QL0eKugTgz/jbdF3mbQ3GnEYiT9ge7G2KyApqoDUe5AmPjp5V4UFUe0cUoCu?=
 =?us-ascii?Q?/SgMJeWWzBT8nMKckbgw0o+gUGGrE7TLLpE2l4lb2q25jIZ1IXsY+0tvitN+?=
 =?us-ascii?Q?7HEpVU/qoZDFWsEdluKmoEaYM0DbWU1fb0QeFMT5d3yBAChpGhF8vcOfxpFu?=
 =?us-ascii?Q?/MWVCuABbwVRo8bDMpUbgc/n5BZ62ErWY5QCRTqinIvcIJkmowgYmAl/JXvf?=
 =?us-ascii?Q?rXJu6PYF30MCIlQob/wP2ZXwg60FAFch6IX8azBzh5oQTxAzwR/OIc64GEnV?=
 =?us-ascii?Q?PQN3lHcqSoNfDCAqX/GfVBpA06kENVv0LYnIsJ+/xBk4yqEotfQknjAJWRQn?=
 =?us-ascii?Q?mCvbUDqGyRF5L3O0Q5K3oLuR5nZXMRNjSplXju9M7R5Mo7xrUwnnDCSrGSNO?=
 =?us-ascii?Q?EX9PDoJBENeQaBqOZwYFurf23sRFFOr37/6lsodVuvfwQEoh2xdhOwg46jDU?=
 =?us-ascii?Q?PQvXzQzONRS525WjBlgIt+7GTtZEVbssbFJRcWVlQVn78lKidO5oMOE66Td/?=
 =?us-ascii?Q?lqWbqsdLjdlVDArNSY4Y4MtCHvXaI5Z5P5b/nM3Wu04aGyXW0QZaEbKDk8UR?=
 =?us-ascii?Q?DDxPHv159Tfz6Kqb5VliSwqc5ze65E5k96c5Uw1vetbDToOrMN9xaM4sLfNk?=
 =?us-ascii?Q?XIT73DY3fhFlBO3tfbfRMxN2HtV4Pa14r9+68hRHFYjQx3Y3adbQrhl7SMbT?=
 =?us-ascii?Q?kjl/oGBTXL9aRMMjflcgG8h/ISsGbU7TygSqBE6NsgZijJ+pqgi35znC0YuV?=
 =?us-ascii?Q?G+2opRzdVdFsZlgjIl7Aob48n3Q+zY9eTGGr4j0lCep9xUKWv8TLzfRzztSb?=
 =?us-ascii?Q?9mHms7CFEBI3hRFrHtcq0GSpnuVJqQSMrBZ89Z3+SnGnxUGraYBkoh0PfCLm?=
 =?us-ascii?Q?sLVGx1fu7g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab72a83-7093-41b7-5602-08da31b66c4d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 12:21:19.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbNpUARhdPHr5XvJTO9n2rrzEFkc2UuCQRzdjdAewa5s8vTzOjmmkIx06lOXvYkQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 20, 2022 at 08:40:41PM -0500, Bob Pearson wrote:
> Currently the rdma_rxe driver has a security weakness due to giving
> objects which are partially initialized indices allowing external
> actors to gain access to them by sending packets which refer to
> their index (e.g. qpn, rkey, etc) causing unpredictable results.
> 
> This patch adds a new API rxe_finalize(obj) which enables looking up
> pool objects from indices using rxe_pool_get_index() for
> AH, QP, MR, and MW. They are added in create verbs only after the
> objects are fully initialized.
> 
> It also adds wait for completion to destroy/dealloc verbs to assure that
> all references have been dropped before returning to rdma_core by
> implementing a new rxe_pool API rxe_cleanup() which drops a reference
> to the object and then waits for all other references to be dropped.
> When the last reference is dropped the object is completed by kref.
> After that it cleans up the object and if locally allocated frees
> the memory.
> 
> Combined with deferring cleanup code to type specific cleanup
> routines this allows all pending activity referring to objects to
> complete before returning to rdma_core.

This seems fine, except the AH problem needs to be fixed before
applying this patch since it looks like it worsens it on the destoy
side now too.

> +int __rxe_cleanup(struct rxe_pool_elem *elem)
> +{
>  	struct rxe_pool *pool = elem->pool;
> +	struct xarray *xa = &pool->xa;
> +	static int timeout = RXE_POOL_TIMEOUT;
> +	unsigned long flags;
> +	int ret, err = 0;
> +	void *xa_ret;
>  
> -	xa_erase(&pool->xa, elem->index);
> +	/* erase xarray entry to prevent looking up
> +	 * the pool elem from its index
> +	 */
> +	xa_lock_irqsave(xa, flags);
> +	xa_ret = __xa_erase(xa, elem->index);
> +	xa_unlock_irqrestore(xa, flags);
> +	WARN_ON(xa_err(xa_ret));
> +
> +	/* if this is the last call to rxe_put complete the
> +	 * object. It is safe to touch elem after this since
> +	 * it is freed below
> +	 */
> +	__rxe_put(elem);
> +
> +	if (timeout) {
> +		ret = wait_for_completion_timeout(&elem->complete, timeout);

The atomic version of this should just spin, I guess, but is there
even any condition where an AH can be held? Maybe the atomic version
just returns succees..

> +		if (!ret) {
> +			pr_warn("Timed out waiting for %s#%d to complete\n",
> +				pool->name, elem->index);
> +			if (++pool->timeouts >= RXE_POOL_MAX_TIMEOUTS)
> +				timeout = 0;
> +
> +			err = -EINVAL;

This is also something of a bug, the xa was erased but now we have
this zombie element floating around, so when we call this again (and
the core code will call it again) the xa will be corrupted.

Could mitigate this by using xa_cmpxchng instead of erase and ignore
the return code.

Jason
