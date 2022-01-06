Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2394863D2
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 12:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiAFLpp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 06:45:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62926 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231423AbiAFLpo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 06:45:44 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206ArslR014117;
        Thu, 6 Jan 2022 11:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=2Cn3LHty2z/HssB9pnPJKzTTw1bQGUHC0SFKijyknUw=;
 b=K/Iz2OlervAqlDlJdYa+ZRJcou15FXcaWIEPVjkg7zxxb1+bXKeURaYsVYwbITy+XN+f
 I/wUJYWlFr/SWWwnPjZf4rxrdPaxbP6q5hW1hZ8ZMUEXrLf+WU3aDof5HN6VtyCCCgMF
 Fm8POf+BBClenHxWuvPVUU7sW9Sv6MCIPo7iefZOcWoCx1i5bvxax43qegRr0YqbcGdu
 ElS7mfHh5lOFBy3lEQxJopm4UsSG1nyQDBo+qIe+alebGFa+QkI5+WqnjM3stLNJT29z
 KVnLVUZ0/yIQLLPHb8R26nRGlk8JNJJk4oKQuktl1EvX+FoG+PukbaX9YH2kjpyWozdP IA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpeheks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 11:45:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206BgBeg143187;
        Thu, 6 Jan 2022 11:45:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3030.oracle.com with ESMTP id 3ddmqhfwvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 11:45:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4I0HuwwoOkHGCVasWXngIE4TPa0kceKR+Gjcf5/BYcpZEtX1zsoYMu4LHNJtdA963KAlu0XCzEC0tLo8EE0P36OFVgra6NFyWRSKGQfwL5F9xqMe0nxfaOoaswo/IH/TDOSyX7S0aSadfE5xis4xJ/f9b18daO/PowjihuphEjXjKrNT51QDq5GAY03jrxwitgukEHIjxQwqnkmyQmSLxQ/cLcks+GN35kIXeOt0ZNovope4BTBr7hPAvpwh57Mf2iaqO2hdHln4UCBc0IZokuMf1NqWGiWnOVJ4OJ8OvCltxtKejh6IjoFxbdIH2YFAphiVAiW/uMcslkPF+kc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Cn3LHty2z/HssB9pnPJKzTTw1bQGUHC0SFKijyknUw=;
 b=G1op/Z+4OYeRBc3583ooPCVPCnzJSrFjBNih89ImZ+g4FaKPYQw7Q3SNexZj0V8crIVtGmwg6OzxJxkG5Cx5gN4VRzFwranEVAewzAQqLDe4B/sXIp3Vo/M4CL+n4HTxU9pYSDhtXcQRc9W+v2kn1bBmHNdffqLFqRF1oLYbr6U8V/h9/Ga4W8QshCvLVg25zUYK6fSrblOJverPy/ipx7NsgU2uT3AEEQ/AEdlawyu9c0/upLIZeN+qQMjmQrRkkwfeLh/RTFeDKFFBsD7FJLWUQwNZjo+0ExhdaH40D98iODZ+XvVboSjIBKuYl454IooFK35crvLLvrpfhjECEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Cn3LHty2z/HssB9pnPJKzTTw1bQGUHC0SFKijyknUw=;
 b=RVYbaN/91X3RlnLaiLbFmSTBnjPQR5VnX6TnQELYsVRwnBPQAPhCZjhq9qYspGbNJn1FfYBwSqaMyVtaJPtY2IUTbNK74VT5+6WDiemJbS4gW1k+ewkyNR+TILgNCd23G5tOrZd/3irJm9BZvFAgzbqJnbtTPGMe+1hXsthAOqk=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1736.namprd10.prod.outlook.com
 (2603:10b6:910:b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 11:45:40 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::38cc:f6b:de96:1e0e%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 11:45:40 +0000
Date:   Thu, 6 Jan 2022 14:45:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     lkayal@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5e: Allocate per-channel stats dynamically at
 first usage
Message-ID: <20220106114529.GA28590@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0035.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::22) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8c4afdd-182f-42fd-a9b3-08d9d10a0fe1
X-MS-TrafficTypeDiagnostic: CY4PR10MB1736:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB173662F4817BE8DB0BFE21FB8E4C9@CY4PR10MB1736.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/XiDZhzOCdbomErhwIPd/xAD8+VHbSaxyzE/OMjtDys9mjgVZbnG0o1BywSNt1YcR4G8XXL0BLDMtkw8++iZY2JrkXK9bXJLtwzHfEs1ULJHRE/6SSs6ZjvsqmThiUwe6TdlskSUWn5VvPXeQ1wOkn8JDFdEuKG1w+W/WqIxhVek/7GhVs7GJUyfOlcEiV6fBNAWT8hrUtDrGlacOpHBqsqq+PtUqpxnDBRIrfTJZpT6dZC3tLWdjwBpbbmxhT3hYx8tcp4h5yg5oLcun6nGAb9yREW7QagBeoUdX43y2rFdEAtwJJbc4hc9crGzM5eoR6Or36maBQ8V/nWpM7dTkve+pNWWfjpfpV+c33CrpvqkWVXOVWxHxyPGcR6EheNEN1LvimmOl+FJnlg/itQMUySSS7EwioeuK/f3o08iFvgp8bUB9YUB1W6qjzVZe3241QgAxHGUdi3yAoQjaVXv7Tjj5mV5B7U34MZxVqlhNbLIeTpZkUEfP57PH3OAoqGBu/pj59NXskse71W1FXxUA0THkl7rNzFG+16EFl/TQYa9CM69D9UoXrU8y0qF8wDkxLsJFhjt9MKnW41C8fl0Pd4MUCyJ1gRqFDAK9/Zarysf8QjQp7Bc/MF5u923fEqJSouSRXkb8aaEzXP6UejPg6pFpcI1Ymd6r9i22arcqk2BdV9vJHDC6xaclWjljm4IyjnYLNdklU6vX31b3l26w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(9686003)(508600001)(44832011)(1076003)(4326008)(6512007)(86362001)(6486002)(33656002)(38100700002)(8676002)(38350700002)(6916009)(6506007)(66476007)(5660300002)(33716001)(8936002)(186003)(66946007)(83380400001)(2906002)(6666004)(52116002)(26005)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZGu1qSGn2ea/Tr//j118oAjeFa2bzMEc5X6/jW3sUbxama5y4HTDDl8Nvr20?=
 =?us-ascii?Q?2UULSB3++U66BulhIDSGRR0aAytr0rZFV9Xbph5VMZHEZlDbTs8sjLwGSMqQ?=
 =?us-ascii?Q?5eGibBUbaGAo92laJ8tKxbZRpXMmxsyNndUYcSeTCW1KGaoCM3YsyTSt4Cbk?=
 =?us-ascii?Q?kkIW92oRUUkzEI1JSMrXRndWEj1qaBK0/zNlCo+y2dEuHoI+kXdM/AfSPesP?=
 =?us-ascii?Q?UDheouOjXwaCUI6XRsnnpSbm//RsgNsv/ZoZG2mG8FhC4K9WgL3IPJF0rJBD?=
 =?us-ascii?Q?6ALauOrThlyqkgx6MX4aot9bErEqJPmMXHxBze/6h0XyCKw7NBmLIeXj4fmv?=
 =?us-ascii?Q?fg3Vhf9FNW8AoDEP9w8rhBwj24oMaBgOjVNa2EDT3loJ8szzEBdaT2bKOOmx?=
 =?us-ascii?Q?UwmGXOaCRQGZR/hyByM7tJchRSG0JrZwPTCv7wHGEvnVoar/xsvEoWX7Cyfl?=
 =?us-ascii?Q?tqljZqBNm+YknUQsZcHzTOxMOLrXErmtCAuAPju7jyDJJX0MgWuszuqhCoTh?=
 =?us-ascii?Q?D2DxKFUnZ/SQcvWV/RfdTKIlacMpikJB50eNKcqAU3MQiL6eyFBmN3jPNv3f?=
 =?us-ascii?Q?Rw7jBWSVSRtDw2NrH8ni/k5WHu44U0awKQYBkbXTZjIclyCUuKy6GZxTb5Of?=
 =?us-ascii?Q?Ocu/5SufTGmICmF0sjOBl3JFVHwzkL8wEDdi2qD7quZf8n7rmanztnu09knL?=
 =?us-ascii?Q?BkOp9bS6hV6igqhWYkiFDVlOmZhj3cshdSuUFe4j+e+yAw2rYeMb1L1OmUVB?=
 =?us-ascii?Q?Qlp2WKbY+H8q3Nf8/EmFJU6+kumWH5iNgJuNq4U64VDqhwOOiRpHfogR7a4i?=
 =?us-ascii?Q?NezkyTwol1tFH+ViW3KNkXi4/FqP2z860dz7LtwXrfBFqQVcgt5qwovhp7tQ?=
 =?us-ascii?Q?lvTaZL9hf0N34g2mcC/VabfzvspPp22ahIiSSY34rzEP2yJpJHoIXw5zotmr?=
 =?us-ascii?Q?C75tTwMJKZwv6HqRQMKdOuZFDoIlYgrTvvnbJz0gkFEcqRMdNk6yCb6KGH5U?=
 =?us-ascii?Q?zvOSvCGKdk5sAYqwCkAWGUln2S4gkjOeUlmsPh0Dn4mN177F2OD/8YHxelxs?=
 =?us-ascii?Q?rhtInBdrFXBljuADmZUSOXZo4BvGyd+RzKEHi5zgNPcaJzzZEteuh2+zRwu8?=
 =?us-ascii?Q?VwuxL2mXtNjr0Vp3DoQ+yVGZo1XGJAGAiQb2rkvoUzSXrypVfdUYTGG1RRdl?=
 =?us-ascii?Q?prf6NQXxbl18Jf93mN/s0YEyLoc9hp7LpfFP8y+PHx+oNR3KncU9IM+gxeBh?=
 =?us-ascii?Q?ztnALkQvRsHKOO1/1oYCNNDFa3HMuhIPB960Bb2V7CyogUU+y45LIYcq6TNt?=
 =?us-ascii?Q?8G2DM2QrMS+0pJqWKFWKwLTpObuxGyv097jEl3xaHQl+aY22Fu6fqcwnj4G4?=
 =?us-ascii?Q?YHeZJQDR80ej9NALR3N5uzanWMolEz9pRs7lzkppD5JnGHCH7YetoW7WQKTq?=
 =?us-ascii?Q?ryFP2MLx1se3eI1z8s1VUk94vqiVImpaS5mMwhRvP2wCWEvFpw28HqENsxy1?=
 =?us-ascii?Q?G+f0zm1mrJAus6j8i+wgPBJlWVwPCtw8+z1S/8NlZaM+7jJYCv91tr1yc2vk?=
 =?us-ascii?Q?ieAluBY6YvNsf4xVufiSBWEBzA/da9n5SNNFSAkAhB5YZF+jcqpGZF3RE4GP?=
 =?us-ascii?Q?1yQ+0gn/JzFKq+HUib3zRQZCdv/m5UpFTXFyXdQnMzCDXDwvBYLG9DGm1Co1?=
 =?us-ascii?Q?bwpx/frUf8GAglZacHYb38UpWBM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c4afdd-182f-42fd-a9b3-08d9d10a0fe1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 11:45:40.2679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMpy5Q31/YlrWSN0FP1wgDJ8eOFg53yAUhquTQ9BUWGQaqTL91CaHK1QG+xqlAYXnepla2yevgqbhTFryQ+TJKfKVXMVaBp7I7HMmCte0L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1736
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060082
X-Proofpoint-ORIG-GUID: DNNinmhtDzAH_897EFB2xDYHZEZ3XfoC
X-Proofpoint-GUID: DNNinmhtDzAH_897EFB2xDYHZEZ3XfoC
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Lama Kayal,

The patch fa691d0c9c08: "net/mlx5e: Allocate per-channel stats
dynamically at first usage" from Sep 22, 2021, leads to the following
Smatch static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/en_main.c:2205 mlx5e_channel_stats_alloc()
	warn: array off by one? 'priv->channel_stats[ix]'

This is from an unpublishable check (too many false positives by design).

drivers/net/ethernet/mellanox/mlx5/core/en_main.c
    2197 static int mlx5e_channel_stats_alloc(struct mlx5e_priv *priv, int ix, int cpu)
    2198 {
    2199         if (ix > priv->stats_nch)  {

I don't think this check makes sense.  As far as I can see "ix" is
always == priv->stats_nch which is set on the last line of the the
function.  Probably the check should be:

	if (ix >= priv->max_nch) {

    2200                 netdev_warn(priv->netdev, "Unexpected channel stats index %d > %d\n", ix,
    2201                             priv->stats_nch);
    2202                 return -EINVAL;
    2203         }
    2204 
--> 2205         if (priv->channel_stats[ix])
    2206                 return 0;
    2207 
    2208         /* Asymmetric dynamic memory allocation.
    2209          * Freed in mlx5e_priv_arrays_free, not on channel closure.
    2210          */
    2211         mlx5e_dbg(DRV, priv, "Creating channel stats %d\n", ix);
    2212         priv->channel_stats[ix] = kvzalloc_node(sizeof(**priv->channel_stats),
    2213                                                 GFP_KERNEL, cpu_to_node(cpu));
    2214         if (!priv->channel_stats[ix])
    2215                 return -ENOMEM;
    2216         priv->stats_nch++;
    2217 
    2218         return 0;
    2219 }

regards,
dan carpenter
