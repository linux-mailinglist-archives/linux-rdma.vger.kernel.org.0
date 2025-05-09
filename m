Return-Path: <linux-rdma+bounces-10177-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313BAB0809
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 04:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664A43B8AF7
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 02:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044C521CFFD;
	Fri,  9 May 2025 02:45:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9855322E;
	Fri,  9 May 2025 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746758730; cv=fail; b=Fk+8OcjaJfBLl5ne+PNsLPCcYDRVLBMzs+6F+pAZVaApI6HepGjTEVoyIMNJSR2qFJ/j5kmUpsFxUMJcWbI9WvvqR8o6i+tRjzw2zg9Ld3Qfl+qD1qQOXOgxKlzwrzqab5kp93qmmhKOCHzhzzdbrIS+5chl41sZeYUGEn7kbVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746758730; c=relaxed/simple;
	bh=C7XcyB/TrMh9qv9dj8tXVNUPDnLA2SFCFBDGxnzUmKI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dvxWlEIM76/atSNI1El+UUhXbjoBci572f9OSMuZKhIPczladTKEVDAU9eoyRJxLbFh6+OT9217mJwc4BAdXwuN7Al9jVkei4NVsJ+noIcYOYlsjAZFD9iM6TWBcc+himJ5TN3EtvSg72JJ7ljI+9w+Xog9bvvMm3VHr9g1NNbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5491K4NP005031;
	Fri, 9 May 2025 02:45:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46d8c16v68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 02:45:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7mwD5mDb/mLKsOdw5RKg/GzTv3wGigUKaidtva8pvswwEUbkHawmX7wkrFR82Xru0dE9L2sDIdeqWSo/vDCtUqpiqucKqpIfEfFKzSkOPF33XUwSnytyhjCoZGnmWL00kCoHi4lKhHgeLEREQmcy2I/laVG8Dyj2Icco1He8OG9LpRzleXdW5T8n1DjGhHCogt27r8uGN8QfuBILo+2RqbbuytZKQC+DztpALyKvDSeomEr42K1le3CLssF1o1taJVBN3jPyZ3al09lTQsQwhWlpE1lwuN+awb3VwFhZStLxnJi5HZwiOQHOCxkkqGfej9Xj/3u96RX1vXGJm+a9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U69U1L7czVM8YzwmkfR71svQXO1x00okCAsuZ4Uoacc=;
 b=Q/1x/ZI18IVqncNZlo+Vv3MMB9T5XOiHs7qjTIA/EwML/Yu1QxE/LPRvmoJkrPP6Az1+hudo1ikpELOdPhQFlVumZ51IKQhMuJo4SSaXG2Sjqd6SOoJlHUBLDj82xLoLldZ29N7tG5iDiko7I239u4HeKNIgqGCPDPAM2HJ7XwuwqVhiI3tEmQGgcG0gD07E0Q6M8YAEaK9f5J/FC4rxzJnxvvszrg3Phueq2SPGDxgXPUxBxtWbu4/gBUkYB4RNke/3A5390B/UDvB195WK/l/Dv4LAcQucxLZakZKWUSrvBfUv7+KSsCeRBvO3WrETkQ4Ky5YYi5Ki/jp2oZ20zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from BYAPR11MB3832.namprd11.prod.outlook.com (2603:10b6:a03:ff::18)
 by CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 02:45:01 +0000
Received: from BYAPR11MB3832.namprd11.prod.outlook.com
 ([fe80::83ab:15a8:cce6:b531]) by BYAPR11MB3832.namprd11.prod.outlook.com
 ([fe80::83ab:15a8:cce6:b531%7]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 02:45:01 +0000
From: Zhi Yang <Zhi.Yang@eng.windriver.com>
To: stable@vger.kernel.org, phaddad@nvidia.com
Cc: xiangyu.chen@windriver.com, zhe.he@windriver.com, harperchen1110@gmail.com,
        markzhang@nvidia.com, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] RDMA/core: Refactor rdma_bind_addr
Date: Fri,  9 May 2025 10:44:47 +0800
Message-Id: <20250509024447.3959342-1-Zhi.Yang@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0142.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::11) To BYAPR11MB3832.namprd11.prod.outlook.com
 (2603:10b6:a03:ff::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3832:EE_|CO1PR11MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: b02a9876-0941-47e9-424a-08dd8ea37e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t8M5qaev8jYRr9n4SJ/Kgo7iowSwvHEzGCFo8M+ORcY7a1XZbfwTCAMsQOU3?=
 =?us-ascii?Q?OUaC56Zrn/ruisc4ClPvVsj396nMNIj5jSkZ7+Zn28H64kC59eO4dzB1X4ZJ?=
 =?us-ascii?Q?jP5gvZ5NgSpLtF/tAkVlGDHhg8UKb19/zR4M9P1oD4E7A1e++RVGTrj06jq/?=
 =?us-ascii?Q?kU6SZRq+iQrzuLpr3EYBF2KXOjI84S3j7Kur5yax0oE5hGtkz80T5v+dc9yG?=
 =?us-ascii?Q?ajhHbKYnmIhMPThsDPFb3O+/WGcJfnJ7uNcyQik68MyaObEnjeT8TkGywiLk?=
 =?us-ascii?Q?aOSr/VcF8jH7K1zhRWAGNeDezekNAV6lXDB6FtT3F+2aK6kxsyrSXmUoT0e0?=
 =?us-ascii?Q?99ELeDJVnZYQHRZl4x4tE7d2ZrsultT1p08q0wZeulEAgGyeOqTr19ljXSik?=
 =?us-ascii?Q?AH9123WM2/Yafq77Bb3MJqGPeNpWNpsaHAI8vZ6HcvsWoyUFOchSACyOWpHd?=
 =?us-ascii?Q?Bw1vJuIAJ5d/Ppk5uAXptn0T2Nxa00jmzMs5G2AHM3J92hebQQiOjamayG8k?=
 =?us-ascii?Q?KUAzkwm2xuh4kqlmIdOG089IGzOQSE/rYA4LS1BB/PML26kNB2fiBfn/Tvkl?=
 =?us-ascii?Q?kwYqDFwHL41FPgl9Neb/tKwEyAAcF1oPNlGNJ7V3tFr0al+CGYFvoSSPrgF+?=
 =?us-ascii?Q?K5QkCBUdjS1tlGcl+QNhJnPDObc9u7Jrr7W2708D3cd6YcgJf/LiYaFHYdEd?=
 =?us-ascii?Q?bGnpJgqDCS04bJ53t5Ky/84mhRTygfVLM5BCz/iINqAFJI8L/rP4lvH6UnHF?=
 =?us-ascii?Q?qoNimg4qDmhn1dutJeV6cS9rSD0BHgTO5GCEwaqA08grijAeIUpi7eA3NxIW?=
 =?us-ascii?Q?iCvRNnmZFSCGNNDfjq54yY+brEnOBmdHapSgHtNuXgc876N1D+97qJb/KH0O?=
 =?us-ascii?Q?qXNmeEV3GYzsk46zy4kNNwgSRPph0ipYpR0uWv1nqwGFIUAYOG1BzKt5sSlL?=
 =?us-ascii?Q?KuPmmGN7fFxOh0EuZdJxrkkcyQ3riB1uDF5p4p98wBCp4BhKNfnTObMG6eWB?=
 =?us-ascii?Q?6Y0mD1JnExWuEADzGX6ZoFbyqXxa9eBVgdJs3aE6f3ZHk3EqAiPS0HeZZbIr?=
 =?us-ascii?Q?A+wqL742Fz+AdROGlD7JlydehtOoEC9pqqlFzoOBggI3Z942xezRrcnXaPT5?=
 =?us-ascii?Q?3ZNx4/fGQh2eHvEzBz3b3H4A7r0n4WWiaQvKaR3DYbm7au59tDWtPvQ1E0A0?=
 =?us-ascii?Q?/j3TLIN94E/JyYXI7relhow7otvt2R7DMcSFKEX7aTLtw8JsTJMERW1LcAsw?=
 =?us-ascii?Q?XfSW4prpvTC71FbxeZJxIR8Xrh8i/2mS+u8R2Jk5NBA3h7IxTMu3EK11ztpb?=
 =?us-ascii?Q?ktHiILTv0XCBQ3XUyMuE9iE7wTmJl+I9A6piSQH46o4jOzFzpEBtQk5mPl5y?=
 =?us-ascii?Q?BS+JIrq+mfc03EPyk5dnw3oY1XFSzG1SENaQ3SOU7me5oGHMDCSG87dpkkoU?=
 =?us-ascii?Q?cEc0vGY296uOeQAZftkt8tfLqU5xvvLCnY6wc8rI561yuwz0H0A+pR0PQjXD?=
 =?us-ascii?Q?7x9tzipZ1R+8Cfw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ks7kFUwlux+TuNn4GWFScRPzfvRSH35jEmrhkd1SE3c1bFjuq2p62AqmBncY?=
 =?us-ascii?Q?XfW/bIT+rl358eYxy1NVaGaioHvHxRCBMm3yye4udtaYSjLSx/9eNeXsc0qI?=
 =?us-ascii?Q?xaiyFSWQE2uBw62XlOJK2/ypRNjUMxwG6IJuUkrdkvNEr01t5rAXQD5dOTrZ?=
 =?us-ascii?Q?vvXHE8LXcUELJMm2Z8VjEcykbHZ53RQBVsYXUkabSBa24z0/LkXprpDay0OA?=
 =?us-ascii?Q?kibnRw5r04WgFJMnSzNfC0WEp4EYLtAyVC+qAhhowcI9Wzc5uNqwHvdbWX8C?=
 =?us-ascii?Q?QB8KyXLYS27SCUDe+AUMUHIvC+1tzOwbM4YMZfajrZOF1bt7ceSIiTlhQHH5?=
 =?us-ascii?Q?aOFmklBk2GRmiYRihmlpOIDF+fKL8NxwHLRSsuNwNi0yWP6Qvawyb95znipO?=
 =?us-ascii?Q?vlx/LeINXy/1AUAW2YGV7pmNl58MPgK0q5s6t5LNoeWFcdPwjVLsX8JasOze?=
 =?us-ascii?Q?ETTaScQ51hGb8o/b103m3sT9YVSM9wfPjcqrJK+YwAbjgEcmvHte8wh/Gk2E?=
 =?us-ascii?Q?tUwpMMmqMR9t1dvMyfkQBJWiePjgzmG/o239T0rLtUEo31V5UZrsgOZg0DEx?=
 =?us-ascii?Q?fJ9CK7rr7LY4aK4IsDbjUsmhipEsAfFbaj4FOunjWSSnDkWdAeoAqukZYW6m?=
 =?us-ascii?Q?uC5MXUwrXg6o4oWpQKI4P/8EzJFnGzt2LrHQPp12bTWGvEktDYvnpZ1Mk96P?=
 =?us-ascii?Q?5zn5priZeb90vEPy/vOfNVvFnVYCfvGVeaDz8uAiLMsQxbbhRyE9QpLeAqOn?=
 =?us-ascii?Q?edz3KK4d9PkNpmlPGloWWxrIUYmNou5NLt3ADfE9xRzFVPt1uTStZM4ZdP8E?=
 =?us-ascii?Q?ZKYmYsAxwTJqWk4saIrEAQhHxkDYYRQmTelnIyIEIk9W/ZJuivzgw5rUexki?=
 =?us-ascii?Q?vqolQl7s+ZBWyJ/x8rxro4Op7A9NxNqhjhWDuRJdU9lBsagELNAOR1/+WTQM?=
 =?us-ascii?Q?dpyScuEVddH01tnM+HkFv19dKhK7eFfdXe5cLK5Z/YtWIfImjbQOYshAIr8D?=
 =?us-ascii?Q?3L0LKWvAGMB7jOO377EbE78PRujzAxT4ci3bLXT4FmY1Qh7fg4YVFjYWwZBH?=
 =?us-ascii?Q?GmMO5Qhzjvacs4U6KpOSW37EYqtLlMFJljBs/5YVttQVO+HQpAGVarjs9w8A?=
 =?us-ascii?Q?BRyCgrw2oa9D+K7a3aB2VB3auYuWNdwnzM9K89jAV7LLizeBrymLKYc48n0V?=
 =?us-ascii?Q?BcWvy/+SSu4zn4MYT6XUaRq95MwFIAd0Z0pfsUqUpiiLvJWdqrpwc/LfEoN7?=
 =?us-ascii?Q?/8rtgsBt8coffXWdsX7znO/1G+z2D8cJT2dOpFjA7Du+XyifBkCyminVDxLF?=
 =?us-ascii?Q?SCbZkM4OSICDoILYUPMSP45nKFTHVWYtPqbgMr6E3EICI3WpL3mTUkm2jrf1?=
 =?us-ascii?Q?/kc9Nfq3DjsAzlFOtNxix6xVwAJePCp7f98EA1AEgZWf5b3//XzNs4XdIwqt?=
 =?us-ascii?Q?dSzqe/hl6rXAHNB62tLtjEktiqVpsBc6bH7mzAw/AwavytI8ol8GfilimrPE?=
 =?us-ascii?Q?m0rMObqrI3apU3AuWjypzWMSyA/MJLS6867ijIx24iMw5zpc/vmU5M7y2mhR?=
 =?us-ascii?Q?XziJqzNhH4zdAogqVdokxnokn0BCJMKYBcBlvnJh?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02a9876-0941-47e9-424a-08dd8ea37e47
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 02:45:00.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db4B/uei7o+9nYLz1SyiGCY8PxSQQ5Uf57dE6R3j0OYUwwe1ai+4uGljxGpTwDwvQP5J2xHpkLimVHKPwY9nPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
X-Authority-Analysis: v=2.4 cv=NIjV+16g c=1 sm=1 tr=0 ts=681d6c37 cx=c_pps a=O5U4z+bWMBJw47+h9fOlNw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=LYueSWIluiJ2wQmGpWgA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: wS2kOKKt-Rmz3QQkcue4P1SnM5T9U1yH
X-Proofpoint-ORIG-GUID: wS2kOKKt-Rmz3QQkcue4P1SnM5T9U1yH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDAyNSBTYWx0ZWRfX8XohCODCv/Mn Gr2SY6Bdol4b31GBlb7XBtIXl8jOY9whHGKtru7915QNN1iIufF5qhMFWHo3G2lw6p9EvZDGP9r NCzkAYU8s6OWvTwiALc4fsFhAvIu9cinKXlaqJvCUu6EKEnHTyurTRHSYEacBnkS3FllpOwkBAB
 nQkZ6zMoehgLDuwznGCOV7Sl0lkIJQ+dM1I2f/oxs2dRvLMGAzM3+jY/g657Kbp1iJe3vwlS6Yy 5Msx/aX0MvZ1UVInQDPBSAsgLWdwINDSjmVmIAZC6nDADk053qqa7/uFZWq0wo1X57hiFCFtju0 Awg5dzKFx743Ms+dnPqfDDih4woN5Hk0MrOYvsIMYl2sUtL3IvyS39itT2N5vRvjziyUUGYI76p
 c4sCC+jus07lWXK4XJ7gzGFoNXF+PLNXn2VRiLw9rQEw0hXXwO0iAHpM5nDQYnZMDs16ipKJ
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_01,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505090025

From: Patrisious Haddad <phaddad@nvidia.com>

commit 8d037973d48c026224ab285e6a06985ccac6f7bf upstream.

Refactor rdma_bind_addr function so that it doesn't require that the
cma destination address be changed before calling it.

So now it will update the destination address internally only when it is
really needed and after passing all the required checks.

Which in turn results in a cleaner and more sensible call and error
handling flows for the functions that call it directly or indirectly.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reported-by: Wei Chen <harperchen1110@gmail.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Link: https://lore.kernel.org/r/3d0e9a2fd62bc10ba02fed1c7c48a48638952320.1672819273.git.leonro@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/infiniband/core/cma.c | 253 +++++++++++++++++-----------------
 1 file changed, 130 insertions(+), 123 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index a204c738e9cf..e8dfce17a5e5 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3364,121 +3364,6 @@ static int cma_resolve_ib_addr(struct rdma_id_private *id_priv)
 	return ret;
 }
 
-static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
-			 const struct sockaddr *dst_addr)
-{
-	struct sockaddr_storage zero_sock = {};
-
-	if (src_addr && src_addr->sa_family)
-		return rdma_bind_addr(id, src_addr);
-
-	/*
-	 * When the src_addr is not specified, automatically supply an any addr
-	 */
-	zero_sock.ss_family = dst_addr->sa_family;
-	if (IS_ENABLED(CONFIG_IPV6) && dst_addr->sa_family == AF_INET6) {
-		struct sockaddr_in6 *src_addr6 =
-			(struct sockaddr_in6 *)&zero_sock;
-		struct sockaddr_in6 *dst_addr6 =
-			(struct sockaddr_in6 *)dst_addr;
-
-		src_addr6->sin6_scope_id = dst_addr6->sin6_scope_id;
-		if (ipv6_addr_type(&dst_addr6->sin6_addr) & IPV6_ADDR_LINKLOCAL)
-			id->route.addr.dev_addr.bound_dev_if =
-				dst_addr6->sin6_scope_id;
-	} else if (dst_addr->sa_family == AF_IB) {
-		((struct sockaddr_ib *)&zero_sock)->sib_pkey =
-			((struct sockaddr_ib *)dst_addr)->sib_pkey;
-	}
-	return rdma_bind_addr(id, (struct sockaddr *)&zero_sock);
-}
-
-/*
- * If required, resolve the source address for bind and leave the id_priv in
- * state RDMA_CM_ADDR_BOUND. This oddly uses the state to determine the prior
- * calls made by ULP, a previously bound ID will not be re-bound and src_addr is
- * ignored.
- */
-static int resolve_prepare_src(struct rdma_id_private *id_priv,
-			       struct sockaddr *src_addr,
-			       const struct sockaddr *dst_addr)
-{
-	int ret;
-
-	memcpy(cma_dst_addr(id_priv), dst_addr, rdma_addr_size(dst_addr));
-	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY)) {
-		/* For a well behaved ULP state will be RDMA_CM_IDLE */
-		ret = cma_bind_addr(&id_priv->id, src_addr, dst_addr);
-		if (ret)
-			goto err_dst;
-		if (WARN_ON(!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND,
-					   RDMA_CM_ADDR_QUERY))) {
-			ret = -EINVAL;
-			goto err_dst;
-		}
-	}
-
-	if (cma_family(id_priv) != dst_addr->sa_family) {
-		ret = -EINVAL;
-		goto err_state;
-	}
-	return 0;
-
-err_state:
-	cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY, RDMA_CM_ADDR_BOUND);
-err_dst:
-	memset(cma_dst_addr(id_priv), 0, rdma_addr_size(dst_addr));
-	return ret;
-}
-
-int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
-		      const struct sockaddr *dst_addr, unsigned long timeout_ms)
-{
-	struct rdma_id_private *id_priv =
-		container_of(id, struct rdma_id_private, id);
-	int ret;
-
-	ret = resolve_prepare_src(id_priv, src_addr, dst_addr);
-	if (ret)
-		return ret;
-
-	if (cma_any_addr(dst_addr)) {
-		ret = cma_resolve_loopback(id_priv);
-	} else {
-		if (dst_addr->sa_family == AF_IB) {
-			ret = cma_resolve_ib_addr(id_priv);
-		} else {
-			/*
-			 * The FSM can return back to RDMA_CM_ADDR_BOUND after
-			 * rdma_resolve_ip() is called, eg through the error
-			 * path in addr_handler(). If this happens the existing
-			 * request must be canceled before issuing a new one.
-			 * Since canceling a request is a bit slow and this
-			 * oddball path is rare, keep track once a request has
-			 * been issued. The track turns out to be a permanent
-			 * state since this is the only cancel as it is
-			 * immediately before rdma_resolve_ip().
-			 */
-			if (id_priv->used_resolve_ip)
-				rdma_addr_cancel(&id->route.addr.dev_addr);
-			else
-				id_priv->used_resolve_ip = 1;
-			ret = rdma_resolve_ip(cma_src_addr(id_priv), dst_addr,
-					      &id->route.addr.dev_addr,
-					      timeout_ms, addr_handler,
-					      false, id_priv);
-		}
-	}
-	if (ret)
-		goto err;
-
-	return 0;
-err:
-	cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY, RDMA_CM_ADDR_BOUND);
-	return ret;
-}
-EXPORT_SYMBOL(rdma_resolve_addr);
-
 int rdma_set_reuseaddr(struct rdma_cm_id *id, int reuse)
 {
 	struct rdma_id_private *id_priv;
@@ -3881,27 +3766,26 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
 }
 EXPORT_SYMBOL(rdma_listen);
 
-int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
+static int rdma_bind_addr_dst(struct rdma_id_private *id_priv,
+			      struct sockaddr *addr, const struct sockaddr *daddr)
 {
-	struct rdma_id_private *id_priv;
+	struct sockaddr *id_daddr;
 	int ret;
-	struct sockaddr  *daddr;
 
 	if (addr->sa_family != AF_INET && addr->sa_family != AF_INET6 &&
 	    addr->sa_family != AF_IB)
 		return -EAFNOSUPPORT;
 
-	id_priv = container_of(id, struct rdma_id_private, id);
 	if (!cma_comp_exch(id_priv, RDMA_CM_IDLE, RDMA_CM_ADDR_BOUND))
 		return -EINVAL;
 
-	ret = cma_check_linklocal(&id->route.addr.dev_addr, addr);
+	ret = cma_check_linklocal(&id_priv->id.route.addr.dev_addr, addr);
 	if (ret)
 		goto err1;
 
 	memcpy(cma_src_addr(id_priv), addr, rdma_addr_size(addr));
 	if (!cma_any_addr(addr)) {
-		ret = cma_translate_addr(addr, &id->route.addr.dev_addr);
+		ret = cma_translate_addr(addr, &id_priv->id.route.addr.dev_addr);
 		if (ret)
 			goto err1;
 
@@ -3921,8 +3805,10 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 		}
 #endif
 	}
-	daddr = cma_dst_addr(id_priv);
-	daddr->sa_family = addr->sa_family;
+	id_daddr = cma_dst_addr(id_priv);
+	if (daddr != id_daddr)
+		memcpy(id_daddr, daddr, rdma_addr_size(addr));
+	id_daddr->sa_family = addr->sa_family;
 
 	ret = cma_get_port(id_priv);
 	if (ret)
@@ -3938,6 +3824,127 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 	cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_IDLE);
 	return ret;
 }
+
+static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
+			 const struct sockaddr *dst_addr)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+	struct sockaddr_storage zero_sock = {};
+
+	if (src_addr && src_addr->sa_family)
+		return rdma_bind_addr_dst(id_priv, src_addr, dst_addr);
+
+	/*
+	 * When the src_addr is not specified, automatically supply an any addr
+	 */
+	zero_sock.ss_family = dst_addr->sa_family;
+	if (IS_ENABLED(CONFIG_IPV6) && dst_addr->sa_family == AF_INET6) {
+		struct sockaddr_in6 *src_addr6 =
+			(struct sockaddr_in6 *)&zero_sock;
+		struct sockaddr_in6 *dst_addr6 =
+			(struct sockaddr_in6 *)dst_addr;
+
+		src_addr6->sin6_scope_id = dst_addr6->sin6_scope_id;
+		if (ipv6_addr_type(&dst_addr6->sin6_addr) & IPV6_ADDR_LINKLOCAL)
+			id->route.addr.dev_addr.bound_dev_if =
+				dst_addr6->sin6_scope_id;
+	} else if (dst_addr->sa_family == AF_IB) {
+		((struct sockaddr_ib *)&zero_sock)->sib_pkey =
+			((struct sockaddr_ib *)dst_addr)->sib_pkey;
+	}
+	return rdma_bind_addr_dst(id_priv, (struct sockaddr *)&zero_sock, dst_addr);
+}
+
+/*
+ * If required, resolve the source address for bind and leave the id_priv in
+ * state RDMA_CM_ADDR_BOUND. This oddly uses the state to determine the prior
+ * calls made by ULP, a previously bound ID will not be re-bound and src_addr is
+ * ignored.
+ */
+static int resolve_prepare_src(struct rdma_id_private *id_priv,
+			       struct sockaddr *src_addr,
+			       const struct sockaddr *dst_addr)
+{
+	int ret;
+
+	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY)) {
+		/* For a well behaved ULP state will be RDMA_CM_IDLE */
+		ret = cma_bind_addr(&id_priv->id, src_addr, dst_addr);
+		if (ret)
+			return ret;
+		if (WARN_ON(!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND,
+					   RDMA_CM_ADDR_QUERY)))
+			return -EINVAL;
+
+	}
+
+	if (cma_family(id_priv) != dst_addr->sa_family) {
+		ret = -EINVAL;
+		goto err_state;
+	}
+	return 0;
+
+err_state:
+	cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY, RDMA_CM_ADDR_BOUND);
+	return ret;
+}
+
+int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
+		      const struct sockaddr *dst_addr, unsigned long timeout_ms)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+	int ret;
+
+	ret = resolve_prepare_src(id_priv, src_addr, dst_addr);
+	if (ret)
+		return ret;
+
+	if (cma_any_addr(dst_addr)) {
+		ret = cma_resolve_loopback(id_priv);
+	} else {
+		if (dst_addr->sa_family == AF_IB) {
+			ret = cma_resolve_ib_addr(id_priv);
+		} else {
+			/*
+			 * The FSM can return back to RDMA_CM_ADDR_BOUND after
+			 * rdma_resolve_ip() is called, eg through the error
+			 * path in addr_handler(). If this happens the existing
+			 * request must be canceled before issuing a new one.
+			 * Since canceling a request is a bit slow and this
+			 * oddball path is rare, keep track once a request has
+			 * been issued. The track turns out to be a permanent
+			 * state since this is the only cancel as it is
+			 * immediately before rdma_resolve_ip().
+			 */
+			if (id_priv->used_resolve_ip)
+				rdma_addr_cancel(&id->route.addr.dev_addr);
+			else
+				id_priv->used_resolve_ip = 1;
+			ret = rdma_resolve_ip(cma_src_addr(id_priv), dst_addr,
+					      &id->route.addr.dev_addr,
+					      timeout_ms, addr_handler,
+					      false, id_priv);
+		}
+	}
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY, RDMA_CM_ADDR_BOUND);
+	return ret;
+}
+EXPORT_SYMBOL(rdma_resolve_addr);
+
+int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+
+	return rdma_bind_addr_dst(id_priv, addr, cma_dst_addr(id_priv));
+}
 EXPORT_SYMBOL(rdma_bind_addr);
 
 static int cma_format_hdr(void *hdr, struct rdma_id_private *id_priv)
-- 
2.34.1


