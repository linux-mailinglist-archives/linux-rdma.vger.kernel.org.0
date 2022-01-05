Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4894F4853D3
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 14:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiAENvh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 08:51:37 -0500
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:41184
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229601AbiAENvg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 08:51:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4h4VBYkLZTIrNSWje5EK9rPbFqUXbUUIrN3FFzvwR1/D3Asn0qj6oN62tImwF+9N8BADyu8XPTwtGmwsG5na0Bc41WDmwzMAcM4kum5XmQhmVe82pq+JrdTvKYHi4BzKx0rhW0qEoYVMAN4BsH3zaCK4X4KezDMvS7qC2PfcfMsbJ1z1LGC0KsG8W76QoffC49wgaVnl3ubW4ptvn4C7qRcKNN7k0fhMZkej1jXWCl5g1+Q7ChrdhWkOZSdx+32RMkp6+VS0Kj46DuMTcelxy7rQ5uqLwqjv/rvU8fKWLcHimZNyOmpufj5OcmOZ6qzdYqtPNpFmHtO8zua+pJCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hEn/nndd+3Wgv80IjbiWL5obgmnNBk3KaLGrkUGbSw=;
 b=aiz3PvUYRDn4lSyLYVCqbLBAD57bpKoC/MWe/mJL+Q3nxz3PArYdp84uBDdoSDtICFmPCKXqZadE0OOFIhdvavjpYiMQ7CYUETqwNXY0Cpbhujw85pp8vjf05wz870EYONAdGaCOCmFZzVK7QwhqnJ0F2Oqrj+xWppN1mPtwGRUHm97GWFwCvwj7VvUzp7Cumx4h6mWTyb65XzgsQkBv+y1vfT5mmdWgVFHBX//sRzHkUyupB5evV2/KqSNqE53h0qcX8AsxZiCi5jl7HZhHhkqgpOjYca2ZRWeF/tNTTVPHf2leRdZ9pJoYsDyju0rEkjM/C1qIkh3DkcWUj1MhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hEn/nndd+3Wgv80IjbiWL5obgmnNBk3KaLGrkUGbSw=;
 b=Pw4G2es859BGZS2WdscjNNsqI2eH5SsqjQiIa+p/bKr0ToluazXP9dORMSaWep36kAHsWAIsvBEqKpKMOO++1rlkeJAC0lP+9oHaO2JJlLu7MNYBtCn2nbUaLwIii3onUxGPreW1LpT5emVjHNejajOHvzc1Bbby9N3qKAJNYpQg6egqXkM4DycQDJSdgEvYEOQU6wiM75rmvS1IxiOFSMDElqU1p0Dvh98IkpZ/2aPrnyHnktDhaQS2dM8k9UsmwP5GIjvY+wbXtYrNb8uKQnqw+PRRSSNGbnsWOcMpLQOSMnTUuWYNDi34rPvEFZX5r38D6N/AtB60ORWKbMDz5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 by PH0PR12MB5467.namprd12.prod.outlook.com (2603:10b6:510:e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 13:51:30 +0000
Received: from PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::2ca5:cf5a:857e:4061]) by PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::2ca5:cf5a:857e:4061%7]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 13:51:30 +0000
Message-ID: <dee99588-0710-c2b2-17b0-ba9d2f959a79@nvidia.com>
Date:   Wed, 5 Jan 2022 21:51:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/4] RDMA/core: Calculate UDP source port based on flow
 label or lqpn/rqpn
Content-Language: en-US
To:     yanjun.zhu@linux.dev, liangwenpeng@huawei.com,
        liweihang@huawei.com, jgg@ziepe.ca, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
References: <20220105080727.2143737-1-yanjun.zhu@linux.dev>
 <20220105080727.2143737-2-yanjun.zhu@linux.dev>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20220105080727.2143737-2-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To PH0PR12MB5401.namprd12.prod.outlook.com
 (2603:10b6:510:d4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 963447db-7385-4b21-0fcb-08d9d05279b3
X-MS-TrafficTypeDiagnostic: PH0PR12MB5467:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54679CFB3E435CD0873D04ADC74B9@PH0PR12MB5467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kd/gGRGfOPaw1f4R4/6AVTWKwaPD1VSxoKAzJDt7A0w+xF2HP6oVOm6imh8HKDMtv2i9WFh9cdPXzoAYeZn6YtkDg3n2U2GHlxswe4qzgWhEsP1SM+YPPU75L6UInkAkuSguZfM9/Ug8rrY4198HnN6clFM8Qg7xAhcO5ABvhk9YhvhwbertU5r+yyjD1SDcS5MfleiriOVnmnBfW6j0CYy/r7/8Ce4/1quOdNdzkP0xpJIVpX+HoQCa1BbcEYOtHIxOLtfUv0920XanffyM2nx3stTt/pOdqxo2Rge6zjaEITgzhr4QuUUt1RTxtaUpIr0l2au5Zu2SyDT+r906T9xs2n6XWFnbZqQToHAFEye1/KUNlUFjGQukf5nUGbFVEXJrVXOntKIYGZYMQvNRXtS+lQfAJuKYplpHc+0D05vVkiotKWIL2sVOFYNDRACBqSaOqJSCTY3j+FgBbAjKrvWm8pdNTtodEVKHlmvVuP3Xyiaes9/PdY+3VLR5OJGvIfWot6rWb+wOKRCm6rFqEgLUhzqJ+dsJ3m6J+qJEA97DEECPHh1OKs2VawpxCPgYmZFA/mb0fTxdqJ1PDqq4siGApLHnRB586UR5xXBJuttH5i4etj9zX8f5EMp2a8n/iueFf7EYd0gpVJdZe+6O11HzomSNqEq+euLua3YbL4+abuQoZuBNnHM3OC4WPgbcWaDh8bknRqxgr79fYfW0lRttFCyjDnoQ90Z2T77Z9ew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(6512007)(6486002)(8936002)(2906002)(8676002)(186003)(26005)(316002)(38100700002)(6506007)(6666004)(2616005)(5660300002)(53546011)(508600001)(86362001)(31686004)(66946007)(66476007)(66556008)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzFIRzJmWmoyMXJlL0I0QnJYUFl6WHZiNWFrMXdJMkpzMTRVcGtuTmFmQUpu?=
 =?utf-8?B?YWZQQ3JPTSszRXJTazE3VTBnOEFxaFdEODE5VldpSVhoOWlyZWRxa1hlK1Rz?=
 =?utf-8?B?ZllxZEtnRDRZd3FXSkNGSGhPRERxNTYzSDR3NDMwcXZqYllReGhZc3ZxdUNy?=
 =?utf-8?B?UWhSdkpJV2ZTSmk3YWRlamF4eUJqYjI5RXBYZ2JtZG9oN2RRendXcVRPeVVS?=
 =?utf-8?B?bzRsMy9nNEUzaFh5RGsyditlMUJXaWNFSGhINGlIZXFtRVRWbDNKWkxHQUlE?=
 =?utf-8?B?YmRtOXNUdmxDd2xqSUVGT1NpWVp0Zm5GWC9XSjc1Q0VseFRycUNGQjV1aE4x?=
 =?utf-8?B?V1c2dmxobE0xQXZ2Q1E1UmxvTWJqT1Z3UUQrSC9hMVQrS0J6Tm02MHJ1cE5F?=
 =?utf-8?B?YkxVOWFrRE9laWhRZWFiQWQzTTRLdGd6M1VIbG5DK1FQMDdDVlBGcXZhTUVV?=
 =?utf-8?B?b1lxc09OSldsUHhSTGt2OHpMVlRMYUlUR2d3S1ZMRGZpaE1sUnZvOVRTYlNV?=
 =?utf-8?B?NXJROFg4ZEljbkZmT1U2dUNkUG10bTZFeWs2ZDVmbGdoQ013R2NXeThBaDl2?=
 =?utf-8?B?aVMxYXFhOXlMZVBJWmFwRWpCckdYRTZlazdzU2p4d0d3MER0a0prUVBLc21D?=
 =?utf-8?B?YnhHTmFsVWE5VDhMVU9pMHp6VmJOQ0wybDJIK2VEMUl2czN0T24yckplTlFQ?=
 =?utf-8?B?VCtIZkszbVNwbXN6RVp0eGRwZWJLdjdJMm8wVDVqcitQZWNoTEdFMHNMOXov?=
 =?utf-8?B?bUZLRjYySnVPb0NGWmE2MnZwYU1pZ0FTaG9XWlhxSHVOQlp3LzVzRjJ4OGtp?=
 =?utf-8?B?em1rcmo3dEN2ZnowdDJ0NkZ0dWUvOWNTaHh4UjhpOE1BazlTSGZibUltUE5M?=
 =?utf-8?B?UXFaaGFTTXNmTVorNHJpMHU1SllhZkczUDIvRytCc0tON0xqbUEwczVOV0pW?=
 =?utf-8?B?dzRKN0ZsSTFDNjNxU0lVMXRWdmQ0aWpRa3dkaGdIVWpUU04xMko5SmtUbms0?=
 =?utf-8?B?eU04SUIrN0htK1h1T3BFbFFIMEdhamp4R1EyL0Y2bUZ4SUJXUXJSZEpxaHph?=
 =?utf-8?B?clFnQzgrNjNyMUo0Ni9KTjNncU9jVCtZOEppRFVZYzl0MHE2WEpRVEFpbnZE?=
 =?utf-8?B?bkxkbkU4b0V4elIzMy9lM2pkZE4xQmtLcHN5TXZlbjJ3TGhuYmhsT3JNOUdF?=
 =?utf-8?B?bU01ZG1OT1VoQk1Wb2RkUlMzUkJpenBSNXU3N2xIcSs1VmhBRXpuUjk4RERr?=
 =?utf-8?B?YnB0bGpuZkF6d3JxUWxxbXhmTXJXb2xRb2tKWUJ0MHpobDlFaWpmaXd3TXRy?=
 =?utf-8?B?U1JQYlF6UlJpdXpVOUlBeUwwQ3dsZ3N3a3o0RUc4S2pSMmJ6ei9WMlpNeHFr?=
 =?utf-8?B?QUdiK0NuV0xObjI0R0JZdWgzeENaSlNMc2xXVFdsY0NEWTRQcEVlVExqQkxN?=
 =?utf-8?B?MjhyWlpnc2xGYU0waS9xcmNycTBtK2NWSkdNcS9yWXBOR0hXQkNOZ3VBY054?=
 =?utf-8?B?cVZPYnlicjM1c1kxMmxwd2FBbXhVUmt2NFZybkdSNlhZZU12aWNnVzhPU2Yz?=
 =?utf-8?B?K2lzZTBCRVVoOUhBcW40b1lGTE9RakhLb3IweklPR0JQbStxZVhuRmJBSGw0?=
 =?utf-8?B?aU96NHlaRlBuN0Z6TkVYL3VUU0RnVThjNE5iU3I1aW9HY2M1a2Z4OXZKTFZo?=
 =?utf-8?B?d0dVWEx3QnpjS3M2VzR5ZVBmdFRkbU9HUGFsVnNxbW44Sk1jaWtOZXZWRS9W?=
 =?utf-8?B?RUFEQ3dWbXo5RG1XdG11Vy8xYUhjRTQxeHJhbHkvY2dGWFZjS0hiWGp0cWJr?=
 =?utf-8?B?RC9mTGdZMEpwbUVqQUhaSFJQWUo0L3U4QkJtK2ovTGFqYVVJSHlqZkk0Q0xJ?=
 =?utf-8?B?RDJheVZuczVzK21TMkNTS2JleVdNY1pITjQrd20yNFRnQU1nWEdkbnhjK1dt?=
 =?utf-8?B?UFJOeHZNNXYvV0JGSWJEVFZ2bU5FU3BHWEJpNENPY2hiUExrSE92OWk0ZXNO?=
 =?utf-8?B?M0N0UjlDZnJCaks4VmlGZksrS3RkUE4wUmkrSFp0V1h4a0NaNEdqV0lwbFNy?=
 =?utf-8?B?S0xpVVhPVEdEWHBIL0N4QVhKdXVxQnlRMXpBdE1YMG9mM1lGeG9SSjZYT0N5?=
 =?utf-8?B?SGFkSElUV25PVjcwd0l6cGZDWDVOQ2RTUmNEbnNPQjMwTjlXUUwyTktyTXd6?=
 =?utf-8?Q?Mxkv75357l6oPVWZI1YoKOk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963447db-7385-4b21-0fcb-08d9d05279b3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 13:51:30.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XenKeQIWO+FN0DFlh+k0suSKVsxCiwYZYlGc0Y0haQxGrXzKbD7ePifX4xnd34PfGTqhPpfmf37XEBbSj3yo3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5467
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/5/2022 4:07 PM, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Calculate and set UDP source port based on the flow label. If flow label
> is not defined in GRH then calculate it based on lqpn/rqpn.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>   include/rdma/ib_verbs.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 6e9ad656ecb7..2f122aa81f0f 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -4749,6 +4749,23 @@ static inline u32 rdma_calc_flow_label(u32 lqpn, u32 rqpn)
>   	return (u32)(v & IB_GRH_FLOWLABEL_MASK);
>   }
>   
> +/**
> + * rdma_get_udp_sport - Calculate and set UDP source port based on the flow
> + *                      label. If flow label is not defined in GRH then
> + *                      calculate it based on lqpn/rqpn.
> + *
> + * @fl:			flow label from GRH

Indent:
+ * @fl:		flow label from GRH

> + * @lqpn:		local qp number
> + * @rqpn:		remote qp number
> + */
> +static inline u16 rdma_get_udp_sport(u32 fl, u32 lqpn, u32 rqpn)
> +{
> +	if (!fl)
> +		fl = rdma_calc_flow_label(lqpn, rqpn);
> +
> +	return rdma_flow_label_to_udp_sport(fl);
> +}
> + >   const struct ib_port_immutable*
>   ib_port_immutable_read(struct ib_device *dev, unsigned int port);
>   #endif /* IB_VERBS_H */

Maybe this and next patch can be squashed into one?
