Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A16648206F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 22:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbhL3VjG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 16:39:06 -0500
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:54523
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236397AbhL3VjG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Dec 2021 16:39:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU3EAvDSQ6aXk6dyDJUT+qGKpMEItgiXIYPjsHw1I1Mxris1G+SfOf8o3CjSkfWNgn40yaJKJXs09G7jCUObdvwzno7fdXkuXBFhC2khdNqGLsBxQR8VpYwP17kwZt/IbHr1fqHu34b4mBM+teYZpQGUcVm/QR/miNcOcenOplRoux3AsiQYK1alvrvVcO/Ad+OxRWuz3xwRwBMmV5V4GuWfpewdoxaNR6uIhHH17THdwvxaLng6vUHdOPr8otkMCawCYpdFIpQtoK+sy1iSyEMtyBUxWt/HybJUaK7gRLYBoxuRXys4aeWh3RgKnXJr9mkdkuVsFhuL32IzRQ6aUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtYnGy3ixW7mtOzaRuNHbpmofdl4XbRIFJ/8AWGfgw4=;
 b=Cr5+PPSRDMcnfr00GWLEZT22W5x3CCPV0PxldmUa0T37uVmWT45a4CSlc/fMNFbLJGgWfMoLWgISHwNSTqcF8RwwugUrNPTBLz2GrE+NhJ62U4EBscLwz4qhj7by7Igun/wi++BTl128Ti+Bflo4LjZr2pt/CbOo3+3/0kcGopCF3z3VdjIMklRndraNQU9/ZAglejtwhV1w5RoQTPK2PQWVqWIZigZzp3eDLvAN7gVpLkqDxRU4FQO+1zQ24RElztc/aV/prMQf2Y7UC17dKwwT0lqLZdCwyaT8tDG7PLegqqpwk4E8q1Dxdw9x4seDs88TtO+zIQ8qWkPicIz1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 MN2PR01MB5887.prod.exchangelabs.com (2603:10b6:208:193::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.19; Thu, 30 Dec 2021 21:39:02 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4823.024; Thu, 30 Dec 2021
 21:39:02 +0000
Message-ID: <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
Date:   Thu, 30 Dec 2021 16:39:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Content-Language: en-US
To:     Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org
Cc:     yanjun.zhu@linux.dev, rpearsonhpe@gmail.com, jgg@nvidia.com,
        y-goto@fujitsu.com, lizhijian@fujitsu.com,
        tomasz.gromadzki@intel.com
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20211230121423.1919550-3-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:207:3c::16) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2c4cc8d-324e-4ef9-08bb-08d9cbdccb92
X-MS-TrafficTypeDiagnostic: MN2PR01MB5887:EE_
X-Microsoft-Antispam-PRVS: <MN2PR01MB5887BAEF862BE564047C493BD6459@MN2PR01MB5887.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+s7t3+MseOQVoGJo2AGpXgu1Gt2SzVIQ2zx+WtEF5jqA9SlhHrQ0aZpP1GzE/vfEz7aEdPFClNeQPoGGWcpyZe306KwxSPfxVPbICZJ8UPpEg8yKZN1fVS5HxaOjqgCiygDY+I7bVRzr+Uw3bOzOgh96ejD5NUKadoMx5mbJXlOtPfxvGwj/XoDrBqIxE5FtFjXWmd3smyjxnX22mrDewrLhCxpXx2DVCdYRyiqHCIZwm6J6FS/wA4RB3yZWkZbeLBYJlYt3tD1Rw0nwZud9P7XBjdxjJMGg35A77Urqy2eB3gNiaidgyBno/YDg4+bewRXs9542pWx9J7zRSYXbDPgVLUNWXs5qjG9BwsF8LKit35WgyiuluqfA406IVKftonIRuRRdq5YMiiMYaygjK04BSR5ioJ1o4dUYcMq6LtqLHdvjwDQDrjrpVKBbi5ZLMoNcEbM/XVwMIP9OUGN/4beKiTzPmU99TENNMgwgFfNSKcZRYGOagjNSRmJD3EEhUtNAC6kC+DMwG/YjJ4MUYOzvI8QGfwX+1JRLARX6AS0jHoYS/3yzXEYF5sdzG4+Z2vzOPlq142YFLETIMGAW9wbiJfsvbkysQrdzor/nK1E0VWm8YiU9TbhLV0KHwIKDSK+RR3eZhStE8eGK+0nU93UKX36eXbFK1s8h4q2qpywo3GwutWNqX8+lbij30/mFvrZjRgzoPU7K6+MMogJOpKi3W9BmwxeCXOXeUT3Vcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(376002)(366004)(396003)(346002)(66476007)(2616005)(2906002)(6512007)(66556008)(5660300002)(508600001)(31696002)(31686004)(8936002)(86362001)(66946007)(4326008)(83380400001)(6486002)(53546011)(8676002)(6506007)(52116002)(26005)(316002)(186003)(36756003)(38100700002)(38350700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGU4QXNlZXBFZWdMNVNMMllVdWt5WXhocUtjTHlCNnYzUmk2aUMybCtuai9r?=
 =?utf-8?B?MlhSb0JmUnM5U0RTSG1PeW5FekpCaFRFTmdDNXZ0UnN3UEovbnlpcGJ2UEt0?=
 =?utf-8?B?dGJTeXhtbUVkNkQ2Z0RLUi9rNHAyNXZvVk8rTkxldUZFSVl5bUlSdXBETmNa?=
 =?utf-8?B?YkFET3AwWkNFTDFBREN0azhsZnN3L2RURFdrYWNRS2tKTVVoLzVDNE5mejND?=
 =?utf-8?B?UGlHMnNBazdhUnQxMXViK0lla2w1bVBCRGFxRVNKY0g0VDJ6Zk9OSzlZQ3ZT?=
 =?utf-8?B?SmlQT1dWV2ZWaC9rTHB4dm9QendrT0RjdjNSNkJWbUdqdjVxNFl6VEFXNEVF?=
 =?utf-8?B?OWUrS0RVdXpUYmlSYVEwdTdEUlJYYjJFRU9BV0NJa1A3Y0FSSkIwdzNQYmQ4?=
 =?utf-8?B?REZVVENFTTA5cldkQ2VyTkNJU1Z4L29QWmN4Z3RKTm9tM1hxenFNTFJuVTlr?=
 =?utf-8?B?c0d1djh4YlFJc2JZeUJsVmdPRTU3d05yRHhZSzFCRkk0ZjFKVWVmU3J1V1Na?=
 =?utf-8?B?MzNhUzB6VkdCcGZBUjZIaStWOXd0Q0NoR3M2amZmTi9ERnJjYUFtWVJEWTkz?=
 =?utf-8?B?NHVBZit2YTU2aE1MT2RGU0NjT2FueDdtL0V4aVNLc2hybTBmdFNRRnBzcmJl?=
 =?utf-8?B?cjR5RG9kUndaWVpEVUxzcGZKTGJURjBHYVE3YlMyOHErNXhqTnZVRSttQ1JY?=
 =?utf-8?B?ZGJwNktBMSs5cUhVMDNMV2xCSEhRZ2YyWU1DZlI0dHp3bUpXYmJqMUszQ0Rz?=
 =?utf-8?B?b2owT0JQS3NRbmdjc1RRUm9YQU5ZNHBuWEpKNGZFRmxnWnpoaTh5TTFraTN5?=
 =?utf-8?B?c3N0dWRXcU92bjg4YTJ1Rk5rRjZyTVJnN0NPNW40QXE4OUtra0x6YmlscEE5?=
 =?utf-8?B?Z0w4YUpISlE4RGFCWGVkbGNZbUJSU0x6R25OSHpkclB0aVo2djFiYU9yUGtl?=
 =?utf-8?B?ckpITHZNNlBOcjJKM3JlQXN2U3J1OTVDWGpqeDB4UnZkcXIzYkc4S0VMNlRX?=
 =?utf-8?B?ZjFsSFNlMHBwK1FYU1gxaGpYSW1WNmROWG1EKzZ6bDVXTDZLd0VqTnhxNnFF?=
 =?utf-8?B?cDl1K0RibjlJTnZFVXVESmZlQzUwZDk3SXB2OXpLNHEveFZkaWp1MDBFYml6?=
 =?utf-8?B?MFZKV2VXc2NWeXFOQ043ay8xMUVaZ013MDJNdG5KM2dmaTBtc2pvMFg2Q3pz?=
 =?utf-8?B?NWtWUGV1MHBXWVMzL0pseGIxYlE5NVRUVmI3SjdRcjJBendIUm1JY3NmakVR?=
 =?utf-8?B?azFxVGEvMVF6L1dtVG5Ya1pTc25hS0RFMEttWVI0NHFYZXhFelpSNEZZV1Fj?=
 =?utf-8?B?bjhxSGdOMEtxYi84L3ZxcVI2NWZ2RGMyZ2V1MmhVamxxaDZLSFJmOXNNMlhF?=
 =?utf-8?B?QWhFTEgvbVA4RGhFbkVmQUhlYWIwV2J5cWxLS3BZb0kvNHFBNmpQSG00aUpV?=
 =?utf-8?B?UU5FaDhCUU85aE9XODBjajNNQ25VTDVkckhCakNzbFdncFVySnA2TDlnaUVH?=
 =?utf-8?B?R3MyQTZ5d0Vna3hHRUdjbkVQQ2dkU21XeEJra0Q2SkJIZVVLenlEUDFvTGFh?=
 =?utf-8?B?R0tjdkcxZlJQZUV2eklVS3RFdy9pMkRVQWlPWWNnamdrS215clRkemtaQUox?=
 =?utf-8?B?RGNZZVVxT2o2SUZlN3VhR2RwUUVzZXMxS0dYUGd5U29mTkdVaE5UTGFaNVYx?=
 =?utf-8?B?TkhUZ3o0NEFRZFRBdjNsTzgxWGRKQU1aWldnNFhqUG9ITzJPOXNPSXdYZTQy?=
 =?utf-8?B?OGpjZmxUUE5YTW5BOVJ0QXIvOEIrdTdiQkdacVNyencvUFJaZXh0cFF2aTV6?=
 =?utf-8?B?ZXBzVEhsbGxsK1F5SEVCT2JzZkt6QXNEOW54aTVPZVJrZytJMmNJVmtzUmlG?=
 =?utf-8?B?cFFkdWo3c2hNZnFKaFJEZGxpMDhMTVZRSnczUzRUcHE4QWp2ZmtvUjVEUDhv?=
 =?utf-8?B?SzRrb1RTVEhuMS9sd0JTUDF5MTJEOHR4a1FsNXBSdGljNTN0SVZkSTBuU0VL?=
 =?utf-8?B?UVpPcE1Obnp5cTZXTjArZ1VwOGljNFhnaitWMHo2Nml6dzF4aE8rVFFkMDBt?=
 =?utf-8?B?QVpsMU9PZTJzbVdIQjZaa3d6V2FqQ0twbmZHbWQ4NklnT3JBbHBreXY4Tnoy?=
 =?utf-8?Q?aRiw=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c4cc8d-324e-4ef9-08bb-08d9cbdccb92
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 21:39:02.0099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXR0ikMyVelxCsrGNOXOFcYfdvpHkSSykDz4bKQ1ueU2ElgROtBZKntj8ayfC0Z1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5887
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/30/2021 7:14 AM, Xiao Yang wrote:
> This patch implements RDMA Atomic Write operation for RC service.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_comp.c   |  4 +++
>   drivers/infiniband/sw/rxe/rxe_opcode.c | 18 ++++++++++
>   drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
>   drivers/infiniband/sw/rxe/rxe_qp.c     |  3 +-
>   drivers/infiniband/sw/rxe/rxe_req.c    | 10 ++++--
>   drivers/infiniband/sw/rxe/rxe_resp.c   | 49 +++++++++++++++++++++-----
>   include/rdma/ib_pack.h                 |  2 ++
>   include/rdma/ib_verbs.h                |  2 ++
>   include/uapi/rdma/ib_user_verbs.h      |  2 ++
>   9 files changed, 81 insertions(+), 12 deletions(-)
> 

<snip>

> +/* Guarantee atomicity of atomic write operations at the machine level. */
> +static DEFINE_SPINLOCK(atomic_write_ops_lock);
> +
> +static enum resp_states process_atomic_write(struct rxe_qp *qp,
> +					     struct rxe_pkt_info *pkt)
> +{
> +	u64 *src, *dst;
> +	struct rxe_mr *mr = qp->resp.mr;
> +
> +	src = payload_addr(pkt);
> +
> +	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
> +	if (!dst || (uintptr_t)dst & 7)
> +		return RESPST_ERR_MISALIGNED_ATOMIC;
> +
> +	spin_lock_bh(&atomic_write_ops_lock);
> +	*dst = *src;
> +	spin_unlock_bh(&atomic_write_ops_lock);

Spinlock protection is insufficient! Using a spinlock protects only
the atomicity of the store operation with respect to another remote
atomic_write operation. But the semantics of RDMA_ATOMIC_WRITE go much
further. The operation requires a fully atomic bus transaction, across
the memory complex and with respect to CPU, PCI, and other sources.
And this guarantee needs to apply to all architectures, including ones
with noncoherent caches (software consistency).

Because RXE is a software provider, I believe the most natural approach
here is to use an atomic64_set(dst, *src). But I'm not certain this
is supported on all the target architectures, therefore it may require
some additional failure checks, such as stricter alignment than testing
(dst & 7), or returning a failure if atomic64 operations are not
available. I especially think the ARM and PPC platforms will need
an expert review.

IOW, nak!

Tom.
