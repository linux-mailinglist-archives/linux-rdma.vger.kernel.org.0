Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D052F479FCD
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Dec 2021 08:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhLSHLV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Dec 2021 02:11:21 -0500
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com ([40.107.244.80]:29148
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232971AbhLSHLU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Dec 2021 02:11:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXkMre/1ByJ92Aeh+FsohjP9hUxwfzbpBVV94PKDpkvIXF6AGWj0ccq225kQsJ9jfBb8oyBLyv1STyHX+NStjMceT+MjGi/uNpGPRkEQnGrE23KluI8fVB49dVtlYgvkczJZQazkEoHe1Wnb6KNHMKo4m/y9ftP7bY2r4k8Lu/jTzxSJdvJ3A+DIsmklfVmOBs+bUPiSktCEhk0FfL2j/EX+KOZbG1FeLQLup0H/7q5SqUPBuepR9eZgFPHat7v4ZFYyEeFOwoVz3P3Luv0/tjIZHXS/koXtWCTpFyEIv9bAc/FOjCJmnJYVo0my9GN4qc3mmcAuWz2DDd+7iFke6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LH1mRKacs8twaJPzRid5+Li8CghDxR/3TLVvuewG95Y=;
 b=akZsuwhmXEEAxgbsr7raboYe4rOJpBwlZBVUjv9mIk2RRgSohooSYCncR2iYc50U/T+kBhehEwxljQL+4eznI6Pwgz2E9jpNTeUw0crEMVCS3zSWcnGJBS2ucWrb3q/OngEfneK9SMvM6xTq+QFOhcEIVmlR5pPSCgbzd/rcG9CH+7VEbcx/4g8JQzTnWUbicX2xspSzyRQ+3v6vARkn2sL3LVZ+vO6i+xaLYaFZfB4bFY0SytYWeQSEUogxMnC311aGvyDdOqM72zXnPPq+cDgJPGRL29gIXN7F92hkuv5OzAZy4CSD5q/Awa5mFL2YEIu4HJLX1eAKthfpT7LuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH1mRKacs8twaJPzRid5+Li8CghDxR/3TLVvuewG95Y=;
 b=aKVoAqArozYyJSEOak9YIm4U8bCeYedljoSltT55+bd1fcHlvkCqz9350IKaB7O6Wyvue7XTR/IrIfLf2IDC42lfFlZHeNsAHLeu37ej3wXkIPdy7DVSDNZrmiWJp7WHnp0ClUHbRR6eGgufvmGa26P9YPJkv3vYZRZv1g5LoISRZ1J2cTDvHXiiiDfJsGdedgZeCrK6QVpN9Sbdpk+Qbu2SYTxD8cq7Qeds/jOVuP+sft1FvNtRWSCvDkJExDxu5ryBsUd/B6CrBB5L3dJBZj6kbd8Z18SOVfyJ3x48UNQyNiP3bzqx5l80BCf1Tpeb7WQJSW+v19EbKoT+J63Stg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 by PH0PR12MB5499.namprd12.prod.outlook.com (2603:10b6:510:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sun, 19 Dec
 2021 07:11:16 +0000
Received: from PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::2ca5:cf5a:857e:4061]) by PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::2ca5:cf5a:857e:4061%6]) with mapi id 15.20.4801.020; Sun, 19 Dec 2021
 07:11:16 +0000
Message-ID: <d76dfbd5-5812-85b8-7d70-c93c3bce3fe1@nvidia.com>
Date:   Sun, 19 Dec 2021 15:11:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 1/1] RDMA/irdma: Make the source udp port vary
Content-Language: en-US
To:     yanjun.zhu@linux.dev, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20211218204438.1345160-1-yanjun.zhu@linux.dev>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20211218204438.1345160-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To PH0PR12MB5401.namprd12.prod.outlook.com
 (2603:10b6:510:d4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03cd8403-124d-43e6-2449-08d9c2bebf6a
X-MS-TrafficTypeDiagnostic: PH0PR12MB5499:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB549955DF33C16F8B3D1FEC12C77A9@PH0PR12MB5499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0SwQ32at2OuM01Y3f1K37b61eslZXU0bzMyRLJ9Y0Ipbjoh8B/tg+keI4T9QdxGLh4agZ93cmaf/7XrxQpznZkVBDCQkQv3Qy1FmfRxLAmdj7hWl0XKdl6mel1Y82xFMfl8vrYKB3Gg/6d9GN0eeLSyjB25esfTFar9LW+/snv2d8YBoKFPCjVxSPuLSrYgdyeSeysO/vlEU7wWmc3iH34w5rjmCf+9f3k5Ckpw1/Wt9YwH0POYnoUxq1NhP/fbcQBRoFSoy/XwiakTGMQ5OFiHhoOSsqdFE8yHpKqG2a7SJPjKxUnupIvpxKbt4k25b0OzFB8B8yg/c44EMpd7koIzAdPM0A36UhjXIj8YlK9+0eeaL4ySabu8uGmzP+k2ROMUDA20JulYyjrou6u6cgyDSOaJm0imx2j1jED/g1PnjsRe/LxYjBf+y7N5ZdsYFrw/6kIiDvWomMdK8JTkLBVFhsQ/qkwMNBjd9NPO38UKvbjRpPF6amAM2A8u2cF3fs+WkQZVSUJeb58WKr1Zf2u50ncKGSR7lFIdx/fXDCL4HkKFcfXVw6S/RnqCfzC2E2HISfYZMOKo0HlWWVHyUht0mgiBYA+3af5ThnBIxfAAIQMZjmEfu3qCORVnLtduvYA9zLNzq60IDXo1OcJ6k3iGovQLlaOagbKSQZ39TFy9E4S6VZeTt6+bJ9YYeVTsaPThpZ2Tv5BU+BLg3gyByf8eWLFBdAzTY2/DdChQnEgpJyiQ7zpiMnd3ljOg/vMn9mz6HndEnZb1Bj+Q4eWId8QeKCEN+m6lPlLOAW3hvPdZ2SJsNMwSV7X7ZhlXa9Bs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(31686004)(6486002)(83380400001)(31696002)(5660300002)(26005)(186003)(966005)(508600001)(36756003)(53546011)(6506007)(86362001)(8936002)(8676002)(316002)(2906002)(66476007)(66556008)(2616005)(6666004)(66946007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGlIdzA5eE85N2ZjMmFISi9Fd1Q4NkZkTXVxRlFQVWFjdlk4bEUrdk56RXFC?=
 =?utf-8?B?UUNxTXZORy94K1N4V3A1eXFkLzd6TDFKeDBPTXlLeGdzWUR1NDlmbk9vYVNt?=
 =?utf-8?B?ZktJWFYyTndUSklrazE4NVdOSGM2S2NrcmhXY3dsZ08rM2Y1alY5ZEFVN3BV?=
 =?utf-8?B?UE5TbFVqNXF6Q0FKUnVuK0x1Ui9RZEY5ZlU0TCtkb3QxMHlpRTZmTGNNQ3RH?=
 =?utf-8?B?dXdwVlNDcUJIN2J0R0Q1c0dNZ0p3cEtHRVIzMjAwV2psbXFlbVdOdm52UWg0?=
 =?utf-8?B?b2JHTnk0YSt2d3Z5bEcxUzVRSnd6bVl4WW4xV2FsVWVIMHovNEVSNXh3UHZU?=
 =?utf-8?B?SkJwNnEvaWlDRXdSaUovdFFpbk02OHNIY1JQeXhqY1o1MFo1Y2Z3dHViZFRP?=
 =?utf-8?B?SCs5ZFdMR0RTMllTdDZaZDZNWHl5eHVURm5PT25NbHdWTk91dk4wUlBCZDhV?=
 =?utf-8?B?V2J6YVc0UUM1czhzRFdqVFluWENBWW5BNTZJVEhXNEpubmpGOWZQd0hCNkx1?=
 =?utf-8?B?SGN6Mm5adUFyaUhZeEdxTFFiYmhuYUJzWExuSTFPa25jRUZZOGNVRVF2Tkph?=
 =?utf-8?B?SlVVWjhUOFVESFg3dlZxUzJlMThicGVVR2pkc29ML2pEVTA4dFFvL0JmV0Iv?=
 =?utf-8?B?dTBDVitlM21XcHdmSnNlcjJRM2FMaTdtcklGcHlQSEFIODFYZGZnL3JRU1ZW?=
 =?utf-8?B?alYrdFpaZklaYkRvSXZKdHQ1MkhDUnpMNVVkRUhSQmhqMEd6VWpuMklDRjAy?=
 =?utf-8?B?VXM1dWNKZVE5TzFlWVJna0lKNU5EMzBOaDVFNHNaOTE4RnQ4OXZaR01mMEw5?=
 =?utf-8?B?ZmJFcVl5SDhLMnZlMXhoMm51elhQcHhPWnQrWkhjb2xJTlFwckYzVURyYnQy?=
 =?utf-8?B?Q0t1T3M2SFIrTmFFMVhtd2ZYK1dZdEprOTA1YzhnSzRNbDhxazlZTytmazQz?=
 =?utf-8?B?WjUwQVVMRjlJSXRLdFBWSUxiSjZwYVRDdFNDT0gyU3VRS0o0alRVdUJCVExC?=
 =?utf-8?B?di9PbHc1eklIOUhNRGtLTGlqeDRWdi8zdkVTc0hFTklSOGxuRnd1dGcxS2Jn?=
 =?utf-8?B?RzhjdnFLTGZTcFB5clVYRlNRSGw2bU1PdGNlQjdINlNZd0pGUFB3eHhuNFJM?=
 =?utf-8?B?eGwwSnArbVhEWlhlS3VZU2N4elQwejVpK1dRdUExWXQweUtWa0ViL0crd1FR?=
 =?utf-8?B?Kzh4bjNvVjV5TGx0ZjlsT0J2eUQwZ21Ia0pIeFJ0RjYxdFQ4MGRoOS9ab05M?=
 =?utf-8?B?bk05QkJlbDkwdXFyQnJ5VFVZYzQ4RXdTTzgwNHplODJPR2d1UlpoZ1ZvT2kw?=
 =?utf-8?B?TFNpRG9Cc1VPNzBjUnZWZWUyQ2c0dlB4M2hRRnkwWnhLRE1mWGMrdGxaQ0lU?=
 =?utf-8?B?TFJVMVVvU0F5SVJUOVQzaXZPcnBkTmJCekdrSjBkM2kycWNocmxUZWxqVjRm?=
 =?utf-8?B?N0lmQ0hQb01UNmFsc3N5UFE1V2VQM1lKVTFmLzBFWm1pczFBSjNuMDREdDF2?=
 =?utf-8?B?SlgwemFjMkpVbmVEdXl1RzgrcWVRRVM0M0I2YnRsZkZnQmdjaisyMTRGcnk2?=
 =?utf-8?B?cFFUSTFHT3FWaW8wL2IrNnoyUUJidTBOeTJ3OVFKUGs0ZEhPb3JMVWFZTXVm?=
 =?utf-8?B?MHVBaHVsTW1Zc1ZJRXdBaUQxL1NEaDBOSllPcEFTZE9qTDFBZzBkZVFPWWV5?=
 =?utf-8?B?Z0x6a1gvUVFtZFFDOUVPT2tjT0dqZXpnei81TFpYZU50cWxQd2k2RFBFQ3dN?=
 =?utf-8?B?VlVQTWxuaElPM2UrK3Q4UFpwdStUSzRMQkxIZ2d6YzdaOTRsTnFxclJXa3o1?=
 =?utf-8?B?OWsxeGt6LzVCSjBFbVExTGtHcDJjbTBEbWFlWkVRbHhSK3ZhYStSaU9nTEJR?=
 =?utf-8?B?Q2dtd0JGR2hla2hqRjBzZUx2d2F1aHNIa1VTYnJPblhNcEhXWG5za2VnNEF6?=
 =?utf-8?B?aE9kQnUxZFpHMjNhZ0QweDI2aXI0cHB3Q0dTN3UvRnluTUYrQ3NrWUlyT2Zw?=
 =?utf-8?B?VVFhV1ZNemRVdXdob1NRNzNNVmZkZGJGVFNiZFdRM210enJqTnRGUzRnNndq?=
 =?utf-8?B?NVcvZ1BocUdtdWcwQnFJbzBwSW1OblFTN3NzQU9GMFZRUnFaL0Q5YkkwTUJr?=
 =?utf-8?B?TlMzckxIOEFRQjZjUUJCS0REaWNNYkUwSnlDRmZwNGEyUDh0RVNTOE5pLzl3?=
 =?utf-8?Q?MVvPrbKtSYIodNXeVG21I+U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cd8403-124d-43e6-2449-08d9c2bebf6a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 07:11:16.5626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ec9hB6oBgaUvDGD5pxYPSFSO8pr0+LNPnfS3JodKXrrq+YArw6+EcLA3LM5BZfjjjUGYROzsGtqWNz6PgdPnXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5499
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/19/2021 4:44 AM, yanjun.zhu@linux.dev wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
> get the source udp port number for a QP based on the grh.flow_label or
> lqpn/rqpn. This provides a better spread of traffic across NIC RX queues.
> The method in the commit 2b880b2e5e03 ("RDMA/mlx5: Define RoCEv2 udp
> source port when set path") is a standard way. So it is also adopted in
> this commit.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V1->V2: Adopt a standard method to get udp source port.
> ---
>   drivers/infiniband/hw/irdma/verbs.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 8cd5f9261692..9fe73d1db0d9 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -1094,6 +1094,15 @@ static int irdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
>          return 0;
>   }
> 
> +
> +static u16 irdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
> +{
> +       if (!fl)
> +               fl = rdma_calc_flow_label(lqpn, rqpn);
> +
> +       return rdma_flow_label_to_udp_sport(fl);
> +}
> +
>   /**
>    * irdma_modify_qp_roce - modify qp request
>    * @ibqp: qp's pointer for modify
> @@ -1159,6 +1168,10 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> 
>          ctx_info->roce_info->pd_id = iwpd->sc_pd.pd_id;
> 
> +       udp_info->src_port = irdma_get_udp_sport(udp_info->flow_label,
> +                                                ibqp->qp_num,
> +                                                roce_info->dest_qp);
> +

FYI that in mlx5 driver the udp_sport is only set when address vector
and dest qpn (IB_QP_AV and IB_QP_DEST_QPN) is provided.

>          if (attr_mask & IB_QP_AV) {
>                  struct irdma_av *av = &iwqp->roce_ah.av;
>                  const struct ib_gid_attr *sgid_attr;
> --
> 2.27.0
> 

