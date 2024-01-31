Return-Path: <linux-rdma+bounces-841-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29F844694
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 18:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FA71F232DE
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900F112DDBF;
	Wed, 31 Jan 2024 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Los17MvV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pRReKMBR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0AD1F164;
	Wed, 31 Jan 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723685; cv=fail; b=opO4EBg/p2kz0drGnxWCsxqVV91G0nPlk15b10+zYOCLmbDpmuCULzi3+3GMqB+f2oPC/Pk5xYLL5huEfSHRz/x3Dho1VnMxqgj5RUJZ83KPfGkHxYcrW35Fn//+AjE8H+FnXengBYbb6Os+ETbdEaIvvXiPSuJt1k44PdnpnSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723685; c=relaxed/simple;
	bh=diMzPcqQrkdl9yRZK+vw2ZLLXS8bT8Niqz43Oo3OQH8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c3Gy7REZhM1RgNXUcYywOhiYGajz48Nvw5wzx2JPNSK4Qk4z4nwg39xVp2lcvJprSO92Ffm36vgyPwObCpaWBtn4Dm0/QPjYZFvs5L4QWjYDXtRERy3rg1QWlLbiyLY1ZgnnjlydVLO660Gi0Pq6EReYdQ/Zpj6g1CLuKXowpyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Los17MvV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pRReKMBR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHBtkP029198;
	Wed, 31 Jan 2024 17:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=OPhjm5oTiovejx0iFLhVchz12fzfZUJ7HCU0+699ZIM=;
 b=Los17MvVo8uvuoZi5XJvVikZpYsENgRbknNrWnjA3l7HSsF+clTKhdwe2ZSPsAvmd3g9
 kOUAFcnS3HrwFDEfClp+C0z7vSgFWeWqY66btgK33QyVg3hdQa1jA8/Ds9B3pNluIdEb
 nv6uVGoigxNlu4d6XKqulAjOR5zwVc+PZWZVvGt+bM2PFHnU9HuqgnrEQpRciFPRMfaJ
 JOcPGk2jySgNzWo9j3fpDSRFHzTTozGUfBpTx53QuhPisIEeaxpK064vklHBmQMrZQQD
 /tnFx4ecirEas3MusLt0Ik2uqOl6ucSaDq2Hz2/zoOCoTkGVLYH3gIteFrfwvstCHpMA YA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcjnwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:54:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VGvqPV011556;
	Wed, 31 Jan 2024 17:54:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr994ppp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:54:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkjhvBZIAiXppUg+kPak0H4K4cI1CAYrHbrOXtJKc8TKBFFliJLh3hTD7WAn97nlBBOO/ko0OkkD/YteaKxzW9CEFxJ3bqG5ABTNONnGVYGo4qKSTTy2JJfDQPVx0DCjLfssENkwqYigC9ztm3fPVWMgsYXg2UGdon62zsUeuyStS27gaEa58CRE9j7a9++48/piNQB761DFPWJLTZD3wedgegFH813Mqw1RXvhi62jZ8rqLoZon6KubvT+02YECaytS0hWso5SwwrZ4bG3GoOhSuC+fS18nA/Lua01sNEBcwraNNrPoWhvOGow1VxYo260+XXdMrUrlFGxc4igMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPhjm5oTiovejx0iFLhVchz12fzfZUJ7HCU0+699ZIM=;
 b=nANYkns41reHQz3RMh+uH7t1ouqaVcC4Ayw5au7CursYPgOBHNy0V+ToZkwOHFQruo1T7ZXcWDR0eNwzJSijDde4l5fyVa9N73W25TWGYOIgk2AeFLOE3SIzqCZ2M2aVnk+/IxW7gOs5dc3b7DIflvRsWtsTjRAXQkaV5D8SuAKKoUMjkIhgkppgVsQDAyQ8xHUIlsiNPVoswnjXa3wRUnhEzD4tRV6meOQaxEkK5b5ictceRRHNO4HLF2G7JaRJT1NwaWaCJb7QpFBPi3BaWwvl37q4phCN4NIajA4sIzeTPw/Aud8G7rO6GiQoydTcZxjJ2UlBDeuFzefiZ9ELuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPhjm5oTiovejx0iFLhVchz12fzfZUJ7HCU0+699ZIM=;
 b=pRReKMBRRTckpqJQ7D8yxpT2Esc2EbcnxeajnLeRtcLVB9PArYdbA0pyU/PyBgF/kTygz8KtygtIoGm3x8Qe1QvzaOtYBAGn1xMfP1Nsscjs8nbqTfOkBgPHdnc17x3oVGAXA/AS4NenvfU5tDigC6Wu30OlvQf0o/3Wv8MdW10=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by LV8PR10MB7989.namprd10.prod.outlook.com (2603:10b6:408:203::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 31 Jan
 2024 17:54:32 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb%5]) with mapi id 15.20.7249.025; Wed, 31 Jan 2024
 17:54:32 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Cc: rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        santosh.shilimkar@oracle.com
Subject: [PATCH v2 1/1] net:rds: Fix possible deadlock in rds_message_put
Date: Wed, 31 Jan 2024 10:54:17 -0700
Message-Id: <20240131175417.19715-1-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|LV8PR10MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba0746e-43a2-4593-9018-08dc2285ae1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gEOS+hsvJj1ror6u0HSpeGRCPmwK6XrxDIEy8ESWLTctWxNvZJBGEnCy7aY15/40eplLLQHzqIrgIjHrVtrYFo80TldDG5yHIurlB51FS7a8yr3PWdPu0oyPAWKFtHNe9Y9kOsmDfqAeZwg0DyW+rHVceXGhHLumL1jtZP+8j8L/gb4go4rRDUO+qKBnM6eE99/jWsxHaTlpJdk6OhGkZ+vlyPBZoi8j7P01EYI9zdrQCnCRqgS1TWJcaRU6mTye1lHgHSsaTdSRMFOnsitWIx2ocLN9gWmjmFHSYzYGWIcQKSHRPXpBN9Fw/UaEmZBWnyFmRxVAMzGDAqRfNKS15D766N9c/JZvCa7TGa0MymoD1DSS9wASSJMmClJM4IqNYSsq0Fq9zm8RVK/P2ieiIf+LvIphNevygDHkMYWtG+HB5Hf075c8M5dxs5+ZLCLUTVAG1LsXSEce8hjWTpu6NxkbbPB5Z9d71xMhGYApLZPFOjwQpXvH5tnr73m63f00A7TvhbqjNjOmTXQ3OCCFtkwRSZj9u6MtWKn2gE7C6xf/FLa51aIWdB4FBDRqMhSr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(2616005)(1076003)(107886003)(83380400001)(478600001)(6486002)(41300700001)(6506007)(6666004)(6512007)(9686003)(36756003)(8936002)(4326008)(8676002)(66556008)(316002)(66946007)(6916009)(66476007)(2906002)(5660300002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gOG5SHpklSticQTGsdDMTbcXx9z6ft2SOMKvb0XVvchkDErMmH9fiwI3Vq0A?=
 =?us-ascii?Q?pk1uvuvIhV315ZgpDCemEo2OjGYjeVCTA+CzW+hrjaPz9YHoT9jBZuiRaNw0?=
 =?us-ascii?Q?TY+92ntAQW7+wC954HTOEoE3rLxm/ZCkyRdSeejTrpiJjRUfGmb1TCFjKgh0?=
 =?us-ascii?Q?/vTLS0InzRDEFXhTyL/GtwI0j+dghrWUTB+rNSKO5Gunb61Q6g/kg2kJWp2n?=
 =?us-ascii?Q?crOICSuY1FCOwIwzBIwSKSArgabKiu+DvtKJfwFmIRu9pCvDHgjNBV7aBjAe?=
 =?us-ascii?Q?0s3C20WSnMqfUPfxW1TyQcQhIlC16nOCzjlIMWZBdiILC5FFUsmFIFp0eOQd?=
 =?us-ascii?Q?kq0B1czUTMmzpCHwudohops2xL9OgasqCut0lx6SNwY3YTxLilvBhGUzq13S?=
 =?us-ascii?Q?uL7XP0xSlpJaRVcDJFgRZ0ujFGVZhtvBC7LI2/AA88ymZRGYR2IXuEArUoWK?=
 =?us-ascii?Q?KGX3QExkXAA441h/MufjbwK2rBLxiltXs8gQfJJeVBzZ5kFlVwk0+RhaSCpd?=
 =?us-ascii?Q?MrB6k7EW2s9kdI2jM1kWp2dnVgmrJ5OUmuXLtioFK4vcOn260YJro2TW/X8r?=
 =?us-ascii?Q?nIZMNNucwz439UtR+BpKxSfoSv+OulQW8xeVoa3/u5pPs1a3gS316/kXx+pn?=
 =?us-ascii?Q?QpHtiHEm0XoWroaeg5s8TT0mMXAvvvw7WMxHKy2Buq6sg5dkWaEXdxYXkGiK?=
 =?us-ascii?Q?vRxNHajOh4xyVM6dPiz3LEwMRKcEZuRIkXXMXLc0BzW4u4xKdCnLSEz8GfAP?=
 =?us-ascii?Q?fHKOYw3cAwhnSdoiv317QJj0pEUi7firrSlCgc1QwxrlfZelQTNOtT6gGFXj?=
 =?us-ascii?Q?TxFLrHQp9dq7V9qtC6jx7on5ZyJ5MCODighdtGuzcGCa9JW/s73kLhaIrbR7?=
 =?us-ascii?Q?qjyD8jrfjC4FXk66+iNEnWB0FVEloa+6qpzoAvDOmQq5al+Iu0i6A9XG0e5r?=
 =?us-ascii?Q?1e+UJistYwzIyqZ9KVeJ0Io2bl3BQ4LU3UnpqgFo6/pke9Tpgan4nbpYi/bW?=
 =?us-ascii?Q?kFj4YyPMPld4/6aa2L1TUTIvOg90gj3TYf74f0ckJg8bbc0X1LjfrQs4RikI?=
 =?us-ascii?Q?qRCnxe2GvTeqt2HY7lpSMg0oxCp740XkFa6yyaebvjtwoz1g4FfoBE6bI2i/?=
 =?us-ascii?Q?dLWwEBsX04sgmxEbquiyR+tL+j0vK6tevnvsURpS4nJwXlPOMJoE2eW6Te8R?=
 =?us-ascii?Q?W1gN0L6zMwnlLhTR5NrsY6zNuW1AAQsgA5iV7JSrSf7SiEF7/rupfJpfz0Ij?=
 =?us-ascii?Q?qco+8GYFjvehDWizy5E+1kNiFjqLgtoQqAh9vQraiZi4YU0/ayAT0pAMrKI6?=
 =?us-ascii?Q?wI9b3y9pCzEgp7el55PhnAhjsM15sHPSYe5rVjncQM/sjjR+jPqbJgdCOY4H?=
 =?us-ascii?Q?rZPbhzu6srI1mClFku4ckEpjXtVftz29KD8xQLJbwxFFTdq8cpq11TRDGfzh?=
 =?us-ascii?Q?WURhALZtnb4HbFymDcyQvi2MQlpmGQRkpZI5j/XvEIRUdtXYQ1k+Qr/9iXMb?=
 =?us-ascii?Q?yskIFyOVIWXGUdADT8QNrTC+JMUVi6zVnGif2AuJCxdw5uwMpR+SA3oELqLT?=
 =?us-ascii?Q?MBz8eOQxVjKUACqNj+CVPekBXYArWUBgq17YTKQ95lCOc6t6Y1FxVkkup9Yk?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rCxFXrQ62421/q0NQjxdIP6ua5BC2GsjL2+JeAFvVMt370kQV8DOXo85Mtg0Ynuuq6KcmS7MZDBRZLeoqPLepoc8rA/XmcqIu3lkkMlpDKKKN/sI3fpT0be2qzTlFNtb+YCTsoT0ID1aSKOB8snI78uBuRH9xx39Kaj25IBceXfQqjK8HApNwULDQXrmFLAw9cMZFDB8Wj/JfokSnphccetD7Nrd84PN3p4DwEBFGjGC2B01nMWfJ35vfR4ribkHxobKWqII/kt2CF33dl7SuoDsk8hlCMZEg3l68ygxiTX5/DVQpc3ocDcGm0NcxO+vnb/KpNW80jbZbpvXm+6q4nojsMuLD7K6CfG2C5tVCOA6lRBs+514+KcJMtLgDIEi34HROToe/BIsQRUMpx3lIqOYcHJOhVs+ZZKi7cjDB9WykOWKdQUP529WEi0c1HVpTNEuWBeGODcHdXn69uKHqB6r4OFyosOThILLK54CGvMO291P1OC5phJ+ERge8ZNwz3O9VBpE287A919a7hvhHir0haGfYpojo9IOhllm5iSghYpEYuSrrsZqZlafQzdxM6qaSvx7zl7zITlInh5LJu+UxufGtLUwSQ/ttK2KXtI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba0746e-43a2-4593-9018-08dc2285ae1d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:54:32.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwABMG4KiTIpTus60V/IEIx89zMtMfkY5jLlchNi53JLx4y4sp/RaPw6J/C+u95Jxa6IT+LdMfrW1AEa3HjVwGHkpXlYx42/cJrGMwU+Fnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310138
X-Proofpoint-ORIG-GUID: 4QjniuBr35drgtdMN4wWcRLdfUIHKjRw
X-Proofpoint-GUID: 4QjniuBr35drgtdMN4wWcRLdfUIHKjRw

From: Allison Henderson <allison.henderson@oracle.com>

Functions rds_still_queued and rds_clear_recv_queue lock a given socket
in order to safely iterate over the incoming rds messages. However
calling rds_inc_put while under this lock creates a potential deadlock.
rds_inc_put may eventually call rds_message_purge, which will lock
m_rs_lock. This is the incorrect locking order since m_rs_lock is
meant to be locked before the socket. To fix this, we move the message
item to a local list or variable that wont need rs_recv_lock protection.
Then we can safely call rds_inc_put on any item stored locally after
rs_recv_lock is released.

Fixes: possible deadlock in rds_message_put
Reported-by: syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com

Fixes: possible deadlock in rds_wake_sk_sleep
Reported-by: syzbot+dcd73ff9291e6d34b3ab@syzkaller.appspotmail.com

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/recv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/rds/recv.c b/net/rds/recv.c
index c71b923764fd..5627f80013f8 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -425,6 +425,7 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
 	struct sock *sk = rds_rs_to_sk(rs);
 	int ret = 0;
 	unsigned long flags;
+	struct rds_incoming *to_drop = NULL;
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	if (!list_empty(&inc->i_item)) {
@@ -435,11 +436,14 @@ static int rds_still_queued(struct rds_sock *rs, struct rds_incoming *inc,
 					      -be32_to_cpu(inc->i_hdr.h_len),
 					      inc->i_hdr.h_dport);
 			list_del_init(&inc->i_item);
-			rds_inc_put(inc);
+			to_drop = inc;
 		}
 	}
 	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 
+	if (to_drop)
+		rds_inc_put(to_drop);
+
 	rdsdebug("inc %p rs %p still %d dropped %d\n", inc, rs, ret, drop);
 	return ret;
 }
@@ -758,16 +762,21 @@ void rds_clear_recv_queue(struct rds_sock *rs)
 	struct sock *sk = rds_rs_to_sk(rs);
 	struct rds_incoming *inc, *tmp;
 	unsigned long flags;
+	LIST_HEAD(to_drop);
 
 	write_lock_irqsave(&rs->rs_recv_lock, flags);
 	list_for_each_entry_safe(inc, tmp, &rs->rs_recv_queue, i_item) {
 		rds_recv_rcvbuf_delta(rs, sk, inc->i_conn->c_lcong,
 				      -be32_to_cpu(inc->i_hdr.h_len),
 				      inc->i_hdr.h_dport);
+		list_move(&inc->i_item, &to_drop);
+	}
+	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
+
+	list_for_each_entry_safe(inc, tmp, &to_drop, i_item) {
 		list_del_init(&inc->i_item);
 		rds_inc_put(inc);
 	}
-	write_unlock_irqrestore(&rs->rs_recv_lock, flags);
 }
 
 /*
-- 
2.34.1


