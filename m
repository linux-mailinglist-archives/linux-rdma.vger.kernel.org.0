Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66204FDA9E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 12:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350812AbiDLJ5e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356924AbiDLHje (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 03:39:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8389D4AE1E
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 00:10:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23C5V5Pe003034;
        Tue, 12 Apr 2022 07:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=r7xlkp5jK5+784ibzk3NhXflAEV6AUOhrHiP0za5AqU=;
 b=rwBj1QlhxDf6UgwKnCyfEqLkqL4LrpUSS/PuhaUQeXvMtY4ZIH7lI9z3nPcpEQjPRu1W
 0rEJq2ofYaVVWOo0dFQN0x4praqiUd+19JvnCLlFVb4dLpUBqMqopAubzkOhA/TdACMx
 rnkj8AH5JSNz63W2I8i49I0dBLr1pC3WNiE73J1o64GExWYrMPcexLnohVXm4AGHWOlO
 e25JULKUXrPFDFANYTu8g2y3dpDBNDeiFeMDX2A3tAxZHFfY/kglWIfG9h8elDw6cQDk
 XXB/b9VA+9uc6lH7GVvJFeVAc1D6uzJwaJeukfDh8pXIY1ebuP7aIcz6/fyy6hdYaV7I Sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x2dugp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 07:10:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23C77J94038755;
        Tue, 12 Apr 2022 07:10:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k2uy1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 07:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esYTZNBWTBuncgi1ZVbZyGFpJsJ8Saiqg/h9zmIifw3EoWVoBdmiMwIS9lY16nLbUCl9wuuaMY4syPVww9ihwHms19HG45Lg1qbdcu81YrY4c9k3rgGSEwfp6PywlE5c55g+zVLhZoOzphStncHzIw7SCckYVv3ERqgnxJI2iUVp3oib4TPBXw11El37st37a3lQ2G26LcE803RmL595NslDLEfbPFZqKOPzYboK5dw/KbqPrs9+GPQ2AzY4HhxhSgyFG3AMXzSuk3e3yOCRDV90Gr3pb4+mpIv+64kFApzTI0m3hjOxKXAxMF+xPYF5OWWNwGA8hDS5nUX9GzgRyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7xlkp5jK5+784ibzk3NhXflAEV6AUOhrHiP0za5AqU=;
 b=JDDax1+Xiz5ZhECqbK05ySGvRs+dbbGFWTn04RaMP0rH4QN5gkAdrId8UqipbKxuc3e/gQyiJ92lmeKL38tQq4e7vj/cOwRl9EnIzuq867J54sVf2TQTdoZP2YnKwtNmG/QjTejc78oblcbFnAWUJfLzEeKzyifB41ChdS8BxYXTHGNyP5V2jHJE9TjqkCcikEtjOiAX/HecItM5+yQ6ksxEKB+pT4n9kxcgjUXO3qujYWFjX2Q65019TelZNOeBGEwP+AJ84cVhdZiU/5dmuSHPzigZkaZ7Q2XjJNBPp7XqZou0Z1dzcr380Rm0s0F9gipx6t+WtHsC6I11FUimIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7xlkp5jK5+784ibzk3NhXflAEV6AUOhrHiP0za5AqU=;
 b=y0l3sIbGDzEEDT2NHzh31m2dgDguRqpHmnDrSJffI21tIFhQ8JsmTBRZsifKYcntsL+O9wcWvcnI9k77a8tGV+htNHffhcUu1WuChSlQmRP3LqUm3PEHYQQtc4p6dH83uXpWhVtyO3Z0DfldjF5qpa2lVSx4nVolZTQ4ECsbt+U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2403.namprd10.prod.outlook.com
 (2603:10b6:405:2f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:10:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 07:10:17 +0000
Date:   Tue, 12 Apr 2022 10:10:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/mlx5: Drop crypto flow steering API
Message-ID: <20220412071008.GA3732@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dd3f291-cd71-4504-d9ab-08da1c537f4c
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2403:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB24036CFAD5D9FBAF7EE150848EED9@BN6PR1001MB2403.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTuulcQCIDlWbRsDBlgch9J+aU43PxnTndBl3f8kbDHbDqq8rSMjKK0rCjdgpjuR11WDPbRj9pQsNaVm4acD4g8049CBLVLgU8n9HDrhD+HnVkbIai2b0btbikKMlFjRjigAvisj9MCLFzhynYoztSoHHZm8y/he1daKwiS/vS7g2on8lEfuUPQxoUc4hhoJFy6M9OYYk8NLVcUKxV+1NO6pZQfP5Utb/R9DDpKdraESwQQv+5mgskg9v3IGxXtTVGTYKBe67a0Ra8hpj0fGdsWBk+ENdgO3crga0PLown9U4I4xCPnMA11N7P7SakQZL0f8oFuuy/5UX4JzT+o3xqIz2BgeTjyS+Po1gkP55z3PCMyG/AKJF8wbu1kTg2rk9F5bBiTw8P67E80wTh5DoJKjsEcfmImHjtoGIDHISHDiCmzIj6TmW7NIfOaYj0JFDt6JJwRJy/lBR8KFSdl3UCMW9yYyfmHfMhv8sTTtV+12CUSAwuHAXfLl2trWTulnquXOfWqqahSxLu58Obc8GrBUBtakIcJAWOmmsRbz/CCk255DwCgM5hUJIV9nyFOOe8g6AycTnT1HgXZMVetNrgVu+xR2mVEWV6gjAOy8riJfx5PvHZnebbWq+Q/9SL0aWblUqArWzV50KeruY1EaTESSezD8j8mdISCdGSrfnFEPiLvJOF7M1UwrC8k0WZhQT/IUDnGB/fIGIceTyCq2Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66946007)(316002)(33716001)(6916009)(8936002)(86362001)(38100700002)(38350700002)(44832011)(83380400001)(186003)(1076003)(26005)(508600001)(33656002)(6666004)(6506007)(8676002)(6512007)(66556008)(66476007)(52116002)(6486002)(5660300002)(2906002)(9686003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IrA7le1BBSpQjJKPPVIXUWYzVwaC/ech/BGNIs+iHPmuW0hohWMB5psWhhwX?=
 =?us-ascii?Q?cMtSQiXGiaR+83zFDffU9dngmxM31C3dQ7ZvZsB2JqveJSV0dDfXkqib0IVp?=
 =?us-ascii?Q?NPTvMO5U9l54iKfxo2vQH4uf9m3lgjyAiRwhjjwHwQPaW+v4MMT7Xr2GA4V1?=
 =?us-ascii?Q?XKBOC4t8G/Fn91xRJKP5FIM0rYoueud50DVHZYpigl2jYBPuUZG/vHEHZLdM?=
 =?us-ascii?Q?kDU4HR3Su8MBibeN8AlhCrzcnNGm8C1BVqzYEq2E8o4SjmSzKywfkGZDyPIR?=
 =?us-ascii?Q?fW+NB+007oeadnWiU2Nv3NtKawOiKnaIw58FqzGwtOyx0kdemV/FO+Czybg2?=
 =?us-ascii?Q?znDq2yOLjAhhDEmiqkRk5YTEIGyiuoLU8Shi2QSvIwwzcnQaYUyeruYo/4+q?=
 =?us-ascii?Q?KghCof1oLIh0zGMezLvcm1uZa4DTpockICMEYzpWV3snTAX8b56uT3QZXogv?=
 =?us-ascii?Q?9TjlYrhGez1Te9Y2UGyDk0uQ0jnmgf9WhiPu9xUolJEcLG5fAVEwvqbXy43h?=
 =?us-ascii?Q?wg5xuKmQAbLTX6u/XlAzoj/k+aRtcBWs804M/RRaySv14x6O0b1nwwOtj/Vt?=
 =?us-ascii?Q?AmOc7y7hPvHkVN66obbuAsmWo6QxBa4KbACgWnSh8x/K3JiidIURk1sjntz7?=
 =?us-ascii?Q?Wea3ZvcqWbLFInK44ApJ1gaNgSMGuYu0vDpfI7coxcjc9C/y//jL+mz6tsXp?=
 =?us-ascii?Q?D2AUyCH2WnxJSUbhJpbbXvylT5LxBAnJM8P1bJ4WedzOk3+KnJ3o44MYapU6?=
 =?us-ascii?Q?WxvaAUvoNiAO4iTUMavdsTYvUTzmelrFOH5iJezzIIx51R6Ybp0xr9lqinD1?=
 =?us-ascii?Q?uWxPryz2BK9Xl9Jzn5gblB0o5LnUUVb7WltX8g7k81sL1lnKnUwrE4B+z4jY?=
 =?us-ascii?Q?v0r2H9hEinlcVE4HgcON7ji/rmR8/ld/gZBOmvtFK3tNr3Ici/Qp3+TTlNRC?=
 =?us-ascii?Q?tYzOx1WcLKBAp1h1ryEQj+loJVt5fbmrkHixhJuPGmp/jCn255KtY1tZB+iT?=
 =?us-ascii?Q?9XLlrkfoXnQIX6qAzPYbbU9zA93nmdMGkQg+Faaj8pyFnc4N999gq7VR3J/3?=
 =?us-ascii?Q?YDoTT1wvIjLezEmQT12mMuXlxdx5Dg4oOht7JDpbyXvkd8bj0o1OcPQP45+7?=
 =?us-ascii?Q?JMb2GsDMNd9LHlS5Y09u8cAK++3PaHJUWWOiIw+UKiy7b41RX1KjTdnfqVUx?=
 =?us-ascii?Q?OWNtinktj1oFhEmHcuUMjxR2mukVa1hjsDv9FeM/1pdf5SIsQozrdI/qkiek?=
 =?us-ascii?Q?6AFT/xsiCj9eOqgMgV/u0Wuxm6NfcmzNiLXmlEwgsbmzi5kJamW2El5OwznS?=
 =?us-ascii?Q?NSJNdZPl0gsiKCHF10HOiwWzeFASuNGh3D12GWqQPlWvtEtb/fLcU40ui7TH?=
 =?us-ascii?Q?KiX+gSP3jDTAFIVSFDFd6byAYpnyxy8b8ET5wHkehIluqeC3eePrPa0rfSZT?=
 =?us-ascii?Q?nGRbYBMYHRyKavK7KScL27hyUFb25gfuxVrxkTxKNBn+Mou1ZJ6NjcyxHCqB?=
 =?us-ascii?Q?utKnWWgKU/6LHrIk/JXcLBLlDDkLeQ2NubicLULosSbqflGxcalTIZCWGKsD?=
 =?us-ascii?Q?1mvvvk312hPi+fipA8XzVnjxYoymA7zOLekA6VSOxARaK2IsIM2MMxfqKZ3o?=
 =?us-ascii?Q?0ZAn4zAS64lxcM6+qrRbFCfnybiRV0bPuwLvvxpMBtRDbA2pvy2+5GwdhPV8?=
 =?us-ascii?Q?3vm7oAghQ3WOUnub+VkhoOKxGMxa8+CnfnDyeFJBmk8xqsoHAitQuJYFPRXK?=
 =?us-ascii?Q?ZDyaEHFTiA2Fia4UhHEpQiYUW0gsrC0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd3f291-cd71-4504-d9ab-08da1c537f4c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 07:10:17.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+gJkl0Gb3Mf4DWb7sO1r7NsaBuTHvIuMKB5l+nEisx/oKYOaTP+7X95wEgfbK8LAWt/3oKX2d3E8SG08XDKqZiGQWAaVm4ZAHdt0+Dq5oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2403
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-12_02:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120034
X-Proofpoint-ORIG-GUID: q1OseDAzq_F8qdZY7kAtv7twoDj8euYN
X-Proofpoint-GUID: q1OseDAzq_F8qdZY7kAtv7twoDj8euYN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Leon Romanovsky,

The patch de8bdb476908: "RDMA/mlx5: Drop crypto flow steering API"
from Apr 6, 2022, leads to the following Smatch static checker
warning:

	drivers/infiniband/hw/mlx5/fs.c:1126 _create_flow_rule()
	warn: duplicate check 'is_egress' (previous on line 1098)

drivers/infiniband/hw/mlx5/fs.c
    1030 static struct mlx5_ib_flow_handler *_create_flow_rule(struct mlx5_ib_dev *dev,
    1031                                                       struct mlx5_ib_flow_prio *ft_prio,
    1032                                                       const struct ib_flow_attr *flow_attr,
    1033                                                       struct mlx5_flow_destination *dst,
    1034                                                       u32 underlay_qpn,
    1035                                                       struct mlx5_ib_create_flow *ucmd)
    1036 {
    1037         struct mlx5_flow_table        *ft = ft_prio->flow_table;
    1038         struct mlx5_ib_flow_handler *handler;
    1039         struct mlx5_flow_act flow_act = {};
    1040         struct mlx5_flow_spec *spec;
    1041         struct mlx5_flow_destination dest_arr[2] = {};
    1042         struct mlx5_flow_destination *rule_dst = dest_arr;
    1043         const void *ib_flow = (const void *)flow_attr + sizeof(*flow_attr);
    1044         unsigned int spec_index;
    1045         u32 prev_type = 0;
    1046         int err = 0;
    1047         int dest_num = 0;
    1048         bool is_egress = flow_attr->flags & IB_FLOW_ATTR_FLAGS_EGRESS;
    1049 
    1050         if (!is_valid_attr(dev->mdev, flow_attr))
    1051                 return ERR_PTR(-EINVAL);
    1052 
    1053         if (dev->is_rep && is_egress)
    1054                 return ERR_PTR(-EINVAL);
    1055 
    1056         spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
    1057         handler = kzalloc(sizeof(*handler), GFP_KERNEL);
    1058         if (!handler || !spec) {
    1059                 err = -ENOMEM;
    1060                 goto free;
    1061         }
    1062 
    1063         INIT_LIST_HEAD(&handler->list);
    1064 
    1065         for (spec_index = 0; spec_index < flow_attr->num_of_specs; spec_index++) {
    1066                 err = parse_flow_attr(dev->mdev, spec,
    1067                                       ib_flow, flow_attr, &flow_act,
    1068                                       prev_type);
    1069                 if (err < 0)
    1070                         goto free;
    1071 
    1072                 prev_type = ((union ib_flow_spec *)ib_flow)->type;
    1073                 ib_flow += ((union ib_flow_spec *)ib_flow)->size;
    1074         }
    1075 
    1076         if (dst && !(flow_act.action & MLX5_FLOW_CONTEXT_ACTION_DROP)) {
    1077                 memcpy(&dest_arr[0], dst, sizeof(*dst));
    1078                 dest_num++;
    1079         }
    1080 
    1081         if (!flow_is_multicast_only(flow_attr))
    1082                 set_underlay_qp(dev, spec, underlay_qpn);
    1083 
    1084         if (dev->is_rep && flow_attr->type != IB_FLOW_ATTR_SNIFFER) {
    1085                 struct mlx5_eswitch_rep *rep;
    1086 
    1087                 rep = dev->port[flow_attr->port - 1].rep;
    1088                 if (!rep) {
    1089                         err = -EINVAL;
    1090                         goto free;
    1091                 }
    1092 
    1093                 mlx5_ib_set_rule_source_port(dev, spec, rep);
    1094         }
    1095 
    1096         spec->match_criteria_enable = get_match_criteria_enable(spec->match_criteria);
    1097 
    1098         if (is_egress) {
    1099                 err = -EINVAL;
    1100                 goto free;

The patch changed this check so we always return -EINVAL.


    1101         }
    1102 
    1103         if (flow_act.action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
    1104                 struct mlx5_ib_mcounters *mcounters;
    1105 
    1106                 err = mlx5_ib_flow_counters_set_data(flow_act.counters, ucmd);
    1107                 if (err)
    1108                         goto free;
    1109 
    1110                 mcounters = to_mcounters(flow_act.counters);
    1111                 handler->ibcounters = flow_act.counters;
    1112                 dest_arr[dest_num].type =
    1113                         MLX5_FLOW_DESTINATION_TYPE_COUNTER;
    1114                 dest_arr[dest_num].counter_id =
    1115                         mlx5_fc_id(mcounters->hw_cntrs_hndl);
    1116                 dest_num++;
    1117         }
    1118 
    1119         if (flow_act.action & MLX5_FLOW_CONTEXT_ACTION_DROP) {
    1120                 if (!dest_num)
    1121                         rule_dst = NULL;
    1122         } else {
    1123                 if (flow_attr->flags & IB_FLOW_ATTR_FLAGS_DONT_TRAP)
    1124                         flow_act.action |=
    1125                                 MLX5_FLOW_CONTEXT_ACTION_FWD_NEXT_PRIO;
--> 1126                 if (is_egress)
                             ^^^^^^^^^
No need to check

    1127                         flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_ALLOW;
    1128                 else if (dest_num)
    1129                         flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
    1130         }
    1131 
    1132         if ((spec->flow_context.flags & FLOW_CONTEXT_HAS_TAG)  &&
    1133             (flow_attr->type == IB_FLOW_ATTR_ALL_DEFAULT ||
    1134              flow_attr->type == IB_FLOW_ATTR_MC_DEFAULT)) {
    1135                 mlx5_ib_warn(dev, "Flow tag %u and attribute type %x isn't allowed in leftovers\n",
    1136                              spec->flow_context.flow_tag, flow_attr->type);
    1137                 err = -EINVAL;
    1138                 goto free;
    1139         }
    1140         handler->rule = mlx5_add_flow_rules(ft, spec,
    1141                                             &flow_act,
    1142                                             rule_dst, dest_num);
    1143 
    1144         if (IS_ERR(handler->rule)) {
    1145                 err = PTR_ERR(handler->rule);
    1146                 goto free;
    1147         }
    1148 
    1149         ft_prio->refcount++;
    1150         handler->prio = ft_prio;
    1151         handler->dev = dev;
    1152 
    1153         ft_prio->flow_table = ft;
    1154 free:
    1155         if (err && handler) {
    1156                 mlx5_ib_counters_clear_description(handler->ibcounters);
    1157                 kfree(handler);
    1158         }
    1159         kvfree(spec);
    1160         return err ? ERR_PTR(err) : handler;
    1161 }

regards,
dan carpenter
