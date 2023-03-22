Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E390A6C547D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 20:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCVTDi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCVTDZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 15:03:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D064B31
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 12:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFrn+4hXG63AGy6Yhfcc2F2FAShrhTwA59GSNem3McqLsc+F0V61fIsF7LTueilmzbcH47iHrGor3Ipa/bP7L2av4D0PAhloPlUYIk1GqESXmYoewoQC5ED/LpFcWKucPgvHFqRNl7Q31HTJxpHGzQEeeb8wHI2UlTHhakOU/2AlKuCEIZto8FfgcSiZpItIZPbppUgYKg5fYcfFSrwVn14pfjdFizpaUtNhh1KOasKj7gPwiDmQuTyPi8UZnTxVNcJ4FV+wDqqVb0hjVWrvztOZ5g6qOgYw/GInVa4GxuKLAQ/UtkmLJ7lqknHOxOCF8Be+QkXO/j1S6BSJrOCRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRGX6NiIOX0moXXekE+2rfk5yvBE7q7UafUp3Tz182I=;
 b=XZ/vxCu90rYuOHce83789CC+GMRQTI5GSvpPAXmq2VJ6nIOtDIovIngu8FvLIh4qXcgYTZNWIdZCj7DBY80+WV/yKBRmUGxgkMrBVby9vF8DMUO1afW0gz9Pbxlpk7b5HgRIb/GGr5+uwzBMxIEQGF22Y/+zZMa35QY4MjN2n9XbcmF8JGziNDt+Ge9ARh5Cl781yo3q42yWQ1WQ+GJQlnRKZB8+rLS3/ZtQ8X6VStn9pSfbIoZwoZbdJCtZWaBctgwYepvQQjkEMY66U33fCpxgm3U0LQ9ockjomSprpcnxXPRzu7Y/5Zco48DbB82o1/OQVZAa//SyY+1WISp5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRGX6NiIOX0moXXekE+2rfk5yvBE7q7UafUp3Tz182I=;
 b=QeQzx2gekCigPlUtvzFv1SmfSgAVCmKj3GunMP3Hx6QywlhonZTag7xy7iqPtA96+GXqY81IDTGpxHD112q3bYB0joSMGi5Gqvh3lK+Z3B5crlasEWO2yQ99Bx5grsi78AcZBMGLLUga9zj/9ncusHD7k+6w3HxZsWwxJJBekYI/CKRtu2XCSDxUwhqoWXim8Vrp3z92B9InqUXQz07VQNDlFNg7SUWk89l9UDkLIdAHrjVSrYrtpmSL9d72c0JETciN/Zl8BnwB9Yd6LgD0kjqmeuiO77b85/V+Qg2d5IRgqhJ0UT9zCKQaKhsUw57auIa1dyjYrsZDRa8Kg0hzvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 19:02:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 19:02:48 +0000
Date:   Wed, 22 Mar 2023 16:02:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH for-next 3/3] libhns: Add support for SVE Direct WQE
 function
Message-ID: <ZBtQ1/3WjWNXAT/b@nvidia.com>
References: <20230225100253.3993383-1-xuhaoyue1@hisilicon.com>
 <20230225100253.3993383-4-xuhaoyue1@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230225100253.3993383-4-xuhaoyue1@hisilicon.com>
X-ClientProxiedBy: BL1PR13CA0390.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: a33a4872-7892-43ab-051f-08db2b080736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BrikYwftDeifivTAWOamoPNMH1U3Byh5E9Ius3/65Sw8xyRnFw4TIHY7Qedjr/41c6YccOOxMfNeWTuXRO+KwyDDOdqTB0Vpr182Sid110zS7j+lg7Zrct5rF2XTavXmdklE5oCcX4n++s0WgB10f5C0JRyq4tG7B3Iq1JKwuKaIp3d5aVMj4pm+Yf0K2G/9rVYbObSKqnDmAooXwRZs4DNRyACwMZoVzCoeGsIzdvXqTJwqk6q8TtyJgkdMi3iH8TaHvVxGucOHo+o4ctKSgRziJU69Lg1HIGnsRvWx6CmaE6n4DwyWWoRHqpXttXAsLyXHYJ8P7h2ZmWnG1sYIjDXhk2CDxS4th7N3N+7rgia6ljkyLFTf/wVlJfBDECf0tQf3EkIU26nJbIJ6pti1YKv6a/XZJMBptzD9F+EP6jPacLmfriDSikTnvpH+dmBewpnqZ3+b3U5wRDBFWlt7CUBLf85GYMub4/r90Vr2YvFtrP9ugsw516xzmMJzn80yEwqwfVcdFpXGmKLHG4Atl5F0m15G3jOUHPzKLYTKQUte8nwckA+blceGFY2teoCFDRUt4aiV3EhNgAp5ErUzjqbhSpWIXgrWXH3q0S9viB3KnE+aYLFk8nKsNgqM5D1E+Fk3kpnddunkb/VDHcR54w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199018)(2616005)(186003)(6486002)(83380400001)(478600001)(66476007)(316002)(66946007)(8676002)(6916009)(66556008)(6512007)(26005)(6506007)(4326008)(41300700001)(5660300002)(8936002)(2906002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3+H7ELp3hP3pLwg9eQgkKAf+lpFNQqFTBDKe+dM7RKZQIEqIBQnRRVes4ci/?=
 =?us-ascii?Q?dZi/Cqf7azv/YHqqMzRTypHrzTr9El3G1hv9wa55u2/GdVHF6Hiop1bkGk0e?=
 =?us-ascii?Q?GLQyKmGKIUFo6ZhbjtTeq5uM0utscM2kMmHs4+rLUdsw8lcYG6GNLgOROC/K?=
 =?us-ascii?Q?Q9dcyobxtjsBOblN6ULSvhW+2G1nKxelUY2evFJTb8foYCqaIai3s94N3678?=
 =?us-ascii?Q?qxpGVUsvUwqPCd/2sj4gNO4qVKanHMmMm2VeWW1SQXrEHpneE4QBXFkSltWs?=
 =?us-ascii?Q?cxnt61NyiqzDUiOYD0+EXbRkthd6XXTqb9gKeQHHmAa2xt69wWIwMmsa1XMm?=
 =?us-ascii?Q?fAKTMaKV2c2yNAki9Q5V3KieHOKHj9jl6mhH/1Hh/fy1++rrPwFFAdGk96H2?=
 =?us-ascii?Q?2XuGMi1UkMef+qzwQhhSxTXD2kHj1B9HcDIU0/52hovDaQS1GgVMML2f51HI?=
 =?us-ascii?Q?ffwiT5dC18uwjQ/uecqrNgfvh0xk1JsM3Xq96D9MD/QGRXkEHKrPIjEKGyEp?=
 =?us-ascii?Q?W6QC49MAHVr+ZIeGSzaX151PDc5VgvGdEzgXULhTOJ/2MpkMl7pIc+yWm/H7?=
 =?us-ascii?Q?yOlTOvpRU+oNFKaIb9Pj9oUneCcEs71LBdeqUwGgBFyAel7j7yT9pAlgsJmv?=
 =?us-ascii?Q?UEk2HgapGRB4SdOm5WmUYtHuDamJr+WYO8XkiJVUZ5mYlXWSpdnGtgtQXYiy?=
 =?us-ascii?Q?WoqUgEvzXbomsOGKWzcf9jHYpkVfH22VmYLmc21lfZLlarcSw0J+wbnL8dOB?=
 =?us-ascii?Q?alF2qdEScNXCBBg5/LpcINOvGwILK19Wps39SB9k7uSrffTjMRLjzE0gJ4gq?=
 =?us-ascii?Q?7/tjU9ZsFCwG8bGg9bR2QHci9j5LwBIUZHgqVBP76vrURzDE68uod4kEPDAN?=
 =?us-ascii?Q?Vwq3cCszN1vcjyY6uh+ZYPCQ2r0xqxLy/4POts3I9xed/HttB6DQOSrhlvYe?=
 =?us-ascii?Q?+1JaufztmXm5WiTrc6bnApuX204VRy/pPdKa+lzObzFPOacO2VfW7wczleBl?=
 =?us-ascii?Q?xVbejd8/v5hWcaKCesUEi9aYFz+Cxo/SczZXrZzjj54D86pSo4m7T/WMMdGj?=
 =?us-ascii?Q?yDY0sUr+peEqJFsJnyIArUp/JN2xqTGOyX69L+cVZ/u9r52QsvaM8NGTTxvN?=
 =?us-ascii?Q?RKuOyBjpSqNC/byw60vZgYFuw8Xvt1Dk4h1Dl+U1RPUknaEsSdfEawTqegrc?=
 =?us-ascii?Q?MaECBqIMA9n4oK57vXI4tQ2IyhZ2E8EdMY7Y1H6BlS0/LOTmT/SFWU682Cqw?=
 =?us-ascii?Q?Je5XixWzS9C0Fv2g10JGmraDZTf8OAaqAZQAbvbzl7MSCfLo+7OdHYSTfB2e?=
 =?us-ascii?Q?s5FqztynDtbgll+Kv/pM18RnLbEGkLo24/tagngmAUUYyrylr/xUcPdzpTI8?=
 =?us-ascii?Q?JRILFQTYEFZ/vTD4zDfbz3wm173zsD38rP1oxEPuDwd23gX/nY3c61dFBXfB?=
 =?us-ascii?Q?uVxhg57hRhv7O2Zig332KNDxOZ47ku83Qzqofr9Xpw1qYf3Cv4/sUhGHVMsQ?=
 =?us-ascii?Q?gQxZ9pgzVRmOvuLBoA3oiWtU/8q9RnzHtN+rnFMZ04v96DxZPycTwgutdJi1?=
 =?us-ascii?Q?p8FG/QNhDNK/VCaE9cEtAEGmOw4z9MtvyIa2Cnoz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33a4872-7892-43ab-051f-08db2b080736
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 19:02:48.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ0woOFn39sgbTy202SInyo49ZtkWDxUfUX6uiCM4rk/JBxis127P0ECkIJn/JFr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Feb 25, 2023 at 06:02:53PM +0800, Haoyue Xu wrote:

> +
> +set_source_files_properties(hns_roce_u_hw_v2.c PROPERTIES COMPILE_FLAGS "${SVE_FLAGS}")
> diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
> index 3a294968..bd457217 100644
> --- a/providers/hns/hns_roce_u_hw_v2.c
> +++ b/providers/hns/hns_roce_u_hw_v2.c
> @@ -299,6 +299,11 @@ static void hns_roce_update_sq_db(struct hns_roce_context *ctx,
>  	hns_roce_write64(qp->sq.db_reg, (__le32 *)&sq_db);
>  }
>  
> +static void hns_roce_sve_write512(uint64_t *dest, uint64_t *val)
> +{
> +	mmio_memcpy_x64_sve(dest, val);
> +}

This is not the right way, you should make this work like the x86 SSE
stuff, using a "__attribute__((target(xx)))"

Look in util/mmio.c and implement a mmio_memcpy_x64 for ARM SVE

mmio_memcpy_x64 is defined to try to generate a 64 byte PCI-E TLP.

If you don't want or can't handle that then you should write your own
loop of 8 byte stores.

>  static void hns_roce_write512(uint64_t *dest, uint64_t *val)
>  {
>  	mmio_memcpy_x64(dest, val, sizeof(struct hns_roce_rc_sq_wqe));
> @@ -314,7 +319,10 @@ static void hns_roce_write_dwqe(struct hns_roce_qp *qp, void *wqe)
>  	hr_reg_write(rc_sq_wqe, RCWQE_DB_SL_H, qp->sl >> HNS_ROCE_SL_SHIFT);
>  	hr_reg_write(rc_sq_wqe, RCWQE_WQE_IDX, qp->sq.head);
>  
> -	hns_roce_write512(qp->sq.db_reg, wqe);
> +	if (qp->flags & HNS_ROCE_QP_CAP_SVE_DIRECT_WQE)

Why do you need a device flag here?

> +		hns_roce_sve_write512(qp->sq.db_reg, wqe);
> +	else
> +		hns_roce_write512(qp->sq.db_reg, wqe);

Isn't this function being called on WC memory already? The usual way
to make the 64 byte write is with stores to WC memory..

Jason
