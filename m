Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9166648208D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 23:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbhL3WSG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 17:18:06 -0500
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:10721
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229528AbhL3WSF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Dec 2021 17:18:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvhIa8QNy89U2PZcfFQZI7Dj95/4rHBHXmFBSH6/oLV4C7bLjqOTAn/QNOCcuMC4EOx0gCzo41O/O6+wjGFlCiL9+Y+aLLPK8QAjMM6LrOhXEYa1yfEGJ3zEueMfs29vJnzSYYd+BY7WggItMOA+wgdSszeCZBSiq7X8ptZYgB5cq47Vh8XGLKsqEGmoXbj56sxZrkgWhQJVfpektli0f20bMhANsCemuhJe7W7FKsr4PCfGGtA2SJCuXUxIwhnVUhCpI0FDgvHJLevvFUykslLEZbcVwP8r3wM1J1Eysg/cvuVeKuA3VSmD8aeRWfBUef6Oy0zrBPu4ItUgCP79LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zL7DOZMNzOeyCcJoOv7mBVRsEG3nDp4sPUX/hxen63A=;
 b=DlJnd/YriVBZkBWfdSmP3FJjx2nof309fGnZh3H+ku0plnUjuri4hfBqvcAup/TU3dnXe3NRZJN0+d0lrm2UrpoXC8JcFqfyvToXGVN/4AXtmisq1PxHH6ywfxBGYSiRq56wx70jy4EALVNPfxGWE0Kl48p4sCWcyAzRJajwgt+gxzN+34fDXa5joe4/k/hvLftU910oCmQSHd6rbu3w6v+auETDJke/TQkGiHgaw6tGCnkbaZiRk85cl1vkYQTmR70CTXsgGbbd/OjEVqh4mLkj372rEAHqPdvaXKjWhDyDskayeYf5eP9EVQHAqcMRr0Rj5og8j8DhMPIdkoB3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 BL0PR01MB4755.prod.exchangelabs.com (2603:10b6:208:7d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.14; Thu, 30 Dec 2021 22:18:03 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4823.024; Thu, 30 Dec 2021
 22:18:03 +0000
Message-ID: <9f97d902-aad5-db0f-f2dc-badf913777c4@talpey.com>
Date:   Thu, 30 Dec 2021 17:18:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Content-Language: en-US
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, linux-rdma@vger.kernel.org,
        zyjzyj2000@gmail.com, jgg@ziepe.ca, aharonl@nvidia.com,
        leon@kernel.org
Cc:     linux-kernel@vger.kernel.org, mbloch@nvidia.com,
        liweihang@huawei.com, liangwenpeng@huawei.com,
        yangx.jy@cn.fujitsu.com, rpearsonhpe@gmail.com, y-goto@fujitsu.com
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:208:234::7) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9add9c0-8b7f-4c05-695e-08d9cbe23ef0
X-MS-TrafficTypeDiagnostic: BL0PR01MB4755:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB475594DC177316A52B6443D0D6459@BL0PR01MB4755.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9BGLJ+upE2uhIc4XxEKEaOrHEiuoSchbMc87UocHvzWjSwUvIK9sEZWaJwtFcI2W2CLZjKcwNXYjVl31xfxfUWKdBjIeW919WTVD6MHgUoZYyIr4dlqnHE/dcfxCMDTvircrfp61NvLD1Au+LFg1XW2zxly8cSRlg7KMqbwubTD/v/CHCqzBISCrEVahK+eS35ZVaNF4JEvaIavUhuRs5mQlqdMmlJoaGe0Lg3LUCUBNRiJdlcqIkcFrET3UdQYFhTexp2rroCE1yoiY/NCuLtpkvKRtT4p5RvJaiYEasjgJLoetuh+jX83wNNW8jb2N1qhPteEIA8pbxsQ5yMAuu4y/eNxwjYhwU8Xao9rx42w2OQ3SaSuIpWEykjrsjAvWP2LSsIL7u1DPiZz2AxmCvLVL6jc/W7xm/TnCN5JhB+Nx2zPWQgEPWRtaznlMjZ6fPrk2ydaGEi4e+oke/5G8i3pZY2bOrHZDrdllGlJcc7+2JBUIroUzogOXvC+O+RL5USyUaIMmXHFOoLsaR/t3XJDvjb37jMUTg2m4+fvilSvvyibq1QL2YZiBS+wNN1rPPKHcTkZQ2F45ZVBnysY1EZq5c4vqBvM/k9ipq5WYQegGFp3KylmJ2+S2LrrR3z8UThUWjUyynGltE4Rvtwcd2QimJPVpDfD+My1llFLB3tjVa7iQ58UOPQnzYOqcSb7F8yM9RYGHatTvI5XpHbdtFVIbxcAG4P6UCEmIMSS51Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39830400003)(366004)(396003)(136003)(2616005)(66946007)(38100700002)(86362001)(6486002)(38350700002)(316002)(6512007)(6506007)(66556008)(5660300002)(66476007)(53546011)(31696002)(26005)(31686004)(8676002)(508600001)(186003)(83380400001)(4326008)(52116002)(7416002)(2906002)(36756003)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2pTMnY4bVBmc3hpWUFIRWg2dXpWdFM0MlFWR1VIWExVQ1c5Z29YYlhDWE1Q?=
 =?utf-8?B?M2hjNDdoRjUxZE1VUzFNWVk1WVg5QzZYY3V3dU9ITENuR0Z3M0EzWTQ0ZFYx?=
 =?utf-8?B?NlhwUDhzNzRLN2pqWDJWb1EvTlZRcG5mMUV0VWNML2JybFdwOWtualBlTmY3?=
 =?utf-8?B?SDRiSTUxU044RUVDWmRoblJWRWhzWVZUY0p4NFJuZHMyd0p0cnNKOEhrbmJS?=
 =?utf-8?B?Yk1aakdHWmdyOVJOZlgwbExkWTUxOG9Mc29sOUVxTlNOd1l5eFVnaTIzT1dV?=
 =?utf-8?B?TjdZM1FFRjdCcGtQcXd4czAyemp3Qzl0UEZ1a01VTW1lUktOcVo5ZWV3QTZN?=
 =?utf-8?B?VzlEQWJUT1BWd0l2TnhzS3hqazFlWFhvWUw1UVg5K0hSb0JRSi82UmR3bHdW?=
 =?utf-8?B?ZW1zYWVxQ0x3Tk5HSllUMDBDaVUxUlZOUHNaZlg5QkU0Mi9KUDBOR1dvWU5W?=
 =?utf-8?B?V0ZoQldjQzhPZEhjMmsyRVBaakNRb0h2Q0RoeGp1bXNJZzdKeUI4MXBaNWlu?=
 =?utf-8?B?MHJmZ1lHTk5nYUtmVElRUytWbTRGTlQ0L3ZrUUVvdGI1KzE3ZVhxNHlHb0Qr?=
 =?utf-8?B?cy9NaFZQNW8zVy90Tk44WUw1Mks2d24rMnI2Ympyd1BBZVVHckh2cUE5ZEpC?=
 =?utf-8?B?UHBmZGFKSC8wRjd5czNsZ0IvZnVWakV6eCsrTU1yS2puRmdMemVnTkY2Ty9P?=
 =?utf-8?B?WC9abExFbW5EUGMzRHpHSDd5SHBOaFg1cVBmOXRBdHd3YXBtYVAxLy9NZUlu?=
 =?utf-8?B?WC8va2pNN0VveHljYXA3QnlxTGdTVGlJMktDU3E5R2s5RkRiWHhXeWxBTDZx?=
 =?utf-8?B?a1VrZGJHNXM1dTFvQkcwS0NvNnp4dldwbzluMXpKUndNc1JFM3ZaVkQ1RlBM?=
 =?utf-8?B?Y2hnUFVFRURMSE8zUTVia1BLUnFXMVN6L0Q5dGFLdUVscTc3LzhEYmplR0pi?=
 =?utf-8?B?ZzJLWjlJdVErNlZrMDgxK3U1TWJkSEhSS3JQR0hIVXJPU1FtUzFteWd1dVB1?=
 =?utf-8?B?bVZ4bEhPcWhYQXpVTDBuQ3Q2YmdYa1lJZU9Ub1BaWk02VHdSWXVXbHIzYkx0?=
 =?utf-8?B?OHVtZ3FsV2huc3NWc0FtSmZQd2s1Z2hPeG41dGM1OStUdEZxN1RPTXVxMTZL?=
 =?utf-8?B?bDdwUnoyNm1IV21ERmJxVmZZYmd1R2Y3dlIxNEVYZzRUMXBFRmwyZTdEZldB?=
 =?utf-8?B?Q0kvT1cxeDYzclp2NkxHV1dKRFY4TlBUWFZZQUV2N0ZudUd3T1ozQS9vcHZH?=
 =?utf-8?B?VWM5Zmt1S0U3N1RaN01QYkZWQzNpQnBYcy8zTGZabldtT211WmdrSzl1cVhy?=
 =?utf-8?B?eTNSSTZFS0tHOG91SU5nRitRSnpMSDdMdEl2dmdjZ296RTVmNFdJbnQrMFlX?=
 =?utf-8?B?STYxVnZ4TzJwSHZ4dTFoTlJZTWl4dUdVYlhSeGUxdk14Z0I1L2pnWStZZ29o?=
 =?utf-8?B?cFhESFVGOVRGZkZvbm9pU1FSYW9tbFlST3hEQjlmZkFLSHVRTkhaeU1XcjVB?=
 =?utf-8?B?bFhRMndCYWtZMGJGYmNiUGNIVkpza1NaYm1GRXlhUENSejdzR2o0Yy9qUlIr?=
 =?utf-8?B?R2dRdE1QeGlEa09EZ0JTQnFHdDlrZ1oxaG4xM1NpeW12c2ttQmVMK3dCa3Zl?=
 =?utf-8?B?Rlppd1pZeDh6WU0rQ3prY1NUWkxSUGI4Vi8wTGpxZmNLTjlmdDhVOFNHb1l1?=
 =?utf-8?B?Umw1WVlCNngrL1llOFFFaHJOSTNtUndncDVHR09rOUVoSzdFeU50V0xqclFN?=
 =?utf-8?B?T1ZoSTI3eXo0MzRYdzBVa0liWU1tcXpybWExNFBUSFdZWGhFUys5TDlMcEtR?=
 =?utf-8?B?dW5wSWVyWEI4MzhQVFhVNEdhYUpDSTJGbUtiaDJMLzVLcVgyYXdXZzNyckdj?=
 =?utf-8?B?Wkl5LytMT0xZckxxWmFJMjJ4Ujk4YXE1bmVjWi9BWERvMU1ncWh5SW52VS8v?=
 =?utf-8?B?SkdOZzB2bGI0eXN0aHV1bEtsd25CU0ZWaGIwRTNGd0J4ZHJMbjNVR2pJSlIx?=
 =?utf-8?B?aENnWWhaak1vQk14U085Y3RZaklSaGIxenFTaThWUE1xS1pTMWttOVNMMVho?=
 =?utf-8?B?RHlJNE5uZ0tYUkE1U2lhYTBXTWFRRmlrc3AxbG9SeGxNTzgva2w4cHpUWkds?=
 =?utf-8?Q?iSbo=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9add9c0-8b7f-4c05-695e-08d9cbe23ef0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 22:18:03.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiED3US6w6/1m8eQ0XUSRsQs5yD07jWzDDLgCzYpH+YZQy/tF7XxykgpxlhcquRV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4755
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/28/2021 3:07 AM, Li Zhijian wrote:
> In contrast to other opcodes, after a series of sanity checking, FLUSH
> opcode will do a Placement Type checking before it really do the FLUSH
> operation. Responder will also reply NAK "Remote Access Error" if it
> found a placement type violation.
> 
> We will persist data via arch_wb_cache_pmem(), which could be
> architecture specific.
> 
> After the execution, responder would reply a responded successfully by
> RDMA READ response of zero size.
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_hdr.h  |  28 ++++++
>   drivers/infiniband/sw/rxe/rxe_loc.h  |   2 +
>   drivers/infiniband/sw/rxe/rxe_mr.c   |   4 +-
>   drivers/infiniband/sw/rxe/rxe_resp.c | 131 ++++++++++++++++++++++++++-
>   include/uapi/rdma/ib_user_verbs.h    |  10 ++
>   5 files changed, 169 insertions(+), 6 deletions(-)
> 

<snip>

> +static int nvdimm_flush_iova(struct rxe_mr *mr, u64 iova, int length)
> +{
> +	int			err;
> +	int			bytes;
> +	u8			*va;
> +	struct rxe_map		**map;
> +	struct rxe_phys_buf	*buf;
> +	int			m;
> +	int			i;
> +	size_t			offset;
> +
> +	if (length == 0)
> +		return 0;

The length is only relevant when the flush type is "Memory Region
Range".

When the flush type is "Memory Region", the entire region must be
flushed successfully before completing the operation.

> +
> +	if (mr->type == IB_MR_TYPE_DMA) {
> +		arch_wb_cache_pmem((void *)iova, length);
> +		return 0;
> +	}

Are dmamr's supported for remote access? I thought that was
prevented on first principles now. I might suggest not allowing
them to be flushed in any event. There is no length restriction,
and it's a VERY costly operation. At a minimum, protect this
closely.

> +
> +	WARN_ON_ONCE(!mr->cur_map_set);

The WARN is rather pointless because the code will crash just
seven lines below.

> +
> +	err = mr_check_range(mr, iova, length);
> +	if (err) {
> +		err = -EFAULT;
> +		goto err1;
> +	}
> +
> +	lookup_iova(mr, iova, &m, &i, &offset);
> +
> +	map = mr->cur_map_set->map + m;
> +	buf	= map[0]->buf + i;
> +
> +	while (length > 0) {
> +		va	= (u8 *)(uintptr_t)buf->addr + offset;
> +		bytes	= buf->size - offset;
> +
> +		if (bytes > length)
> +			bytes = length;
> +
> +		arch_wb_cache_pmem(va, bytes);
> +
> +		length	-= bytes;
> +
> +		offset	= 0;
> +		buf++;
> +		i++;
> +
> +		if (i == RXE_BUF_PER_MAP) {
> +			i = 0;
> +			map++;
> +			buf = map[0]->buf;
> +		}
> +	}
> +
> +	return 0;
> +
> +err1:
> +	return err;
> +}
> +
> +static enum resp_states process_flush(struct rxe_qp *qp,
> +				       struct rxe_pkt_info *pkt)
> +{
> +	u64 length = 0, start = qp->resp.va;
> +	u32 sel = feth_sel(pkt);
> +	u32 plt = feth_plt(pkt);
> +	struct rxe_mr *mr = qp->resp.mr;
> +
> +	if (sel == IB_EXT_SEL_MR_RANGE)
> +		length = qp->resp.length;
> +	else if (sel == IB_EXT_SEL_MR_WHOLE)
> +		length = mr->cur_map_set->length;

I'm going to have to think about these
> +
> +	if (plt == IB_EXT_PLT_PERSIST) {
> +		nvdimm_flush_iova(mr, start, length);
> +		wmb(); // clwb follows by a sfence
> +	} else if (plt == IB_EXT_PLT_GLB_VIS)
> +		wmb(); // sfence is enough

The persistence and global visibility bits are not mutually
exclusive, and in fact persistence does not imply global
visibility in some platforms. They must be tested and
processed individually.

	if (plt & IB_EXT_PLT_PERSIST)
		...
	else if (plt & IB_EXT_PLT_GLB_VIS)
		..

Second, the "clwb" and "sfence" comments are completely
Intel-specific. What processing will be done on other
processor platforms???

Tom.
