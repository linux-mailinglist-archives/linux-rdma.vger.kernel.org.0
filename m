Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C25644ACCE
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Nov 2021 12:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbhKILr0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Nov 2021 06:47:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28552 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229879AbhKILrZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Nov 2021 06:47:25 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9Bh17B015325;
        Tue, 9 Nov 2021 11:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=vWl9ptJo305olw3/aPNnNwvnHnBm17f7xDVnJqQi6Yk=;
 b=DJrSjxRxtjcMp02OxIUhKiXA3sBA0ToinPhE5lt9segP4HgbcJ0GF2lLws2gC/ck6Fgn
 xFr769LnWiNN/OrgBxyDVjF03NH71qVxbQvmYX/iAt9lEJv5z6sEYBWBuSNqpULOspjy
 1+943b+fZ1u2QOv1IfKqhRHr9QE5+9oUIwioVKGDsV4U/hqakwqkvXdfhvYiIeMoKjf9
 Qjok7/WauQjpINS5V/P9i6tcBW9OzODxCSBQDUcCirpiSUo8ey+hzWo0j2vU+gEpQ1fV
 OIDR/a2fWSahLuoqYH8EzZRdwI1BqPgAgvwtYeqXdGd72VDkMdW+S5zkkLkK3sa23Vjo 1A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6usnj65j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 11:44:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A9BaVNS093337;
        Tue, 9 Nov 2021 11:44:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3020.oracle.com with ESMTP id 3c5hh3fvhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 11:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo5tfVs5echH/sVB4kAz0Bbgu92ge27qMFXXHktHsgq0gFTAGekKU7Pvx1RUAq/ajUSGJMfBtuvbeAnr52md/ttinVJPiAOw+wvRviaByHy8HX0s4xX1iz3sI7cyl/KbCr27QQSccHN4Db4yPl6i2qAa6khj8cdlWWvCOA2hQT/7uemBnDJZF13JlHzNXiM3alVsnPGvVXCyKT3Ez+55+i0NFNmjzk9du+3NmkMSiMQb8wJO08ZTjGAwA5GWSc6l5Lz6sUOFUntU3KOsek2Ni4+Qi1RMubRYP77Vtrq80dQkWEkuPbhJElVBeQ6PMYdPR9Y+a5ZHCDcIR8Kub3x2Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWl9ptJo305olw3/aPNnNwvnHnBm17f7xDVnJqQi6Yk=;
 b=TQerDtGIGPY6P+EBISpg4uLaNip4gdumNP5OH7mgthMWSatCk8jjPl2aTTIlp96nQTslKYsybspXDnS1ZQgw+MD+p/5TgmQZqc8EXV8we3+hR3Ir8L72msuFFzqupo6UnkaKxqSxjIin5/hupwyLcEbvHWYaTnfol7lFJtHCc66oEsi4+JhAjzPiB7TVKTFMuRDt+bubKvEXAJVqLUEfiyetxlh6V/xa+bkiW5kohcK4ToUn2qH5nfr+r81ixoKCLQvHambheNgiz2lDN0SAZDgTBesO4ZAo5uTTBvQvaKa9p6OAYEuJBwJ7ZXPQUPcfZZutrZCa1/SANHahH3zrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWl9ptJo305olw3/aPNnNwvnHnBm17f7xDVnJqQi6Yk=;
 b=koOp6TFhrW0tKZ7onlLNqTnmLezBVHhWwhh4ATijIFfbKxB8pOsIu8uTn3GeNUG1s5gdajMGAoKd5L5UOSASits664sCClNBP40RG/6SmkX6qH7uFiqwmTpKFEUgSLTIUHxuwGFPinc/ho1rnZSZ79upsPu8ehH4K18oEEhQMP0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5752.namprd10.prod.outlook.com
 (2603:10b6:303:18d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 11:44:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.015; Tue, 9 Nov 2021
 11:44:34 +0000
Date:   Tue, 9 Nov 2021 14:44:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saeed Mahameed <saeedm@nvidia.com>,
        Ben Ben-Ishay <benishay@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5e: Fix signedness bugs in
 mlx5e_build_shampo_hd_umr()
Message-ID: <20211109114411.GI2026@kadam>
References: <20211109114159.GA15855@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109114159.GA15855@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 11:44:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92e066bc-70f4-43d6-0536-08d9a3764ccf
X-MS-TrafficTypeDiagnostic: MW4PR10MB5752:
X-Microsoft-Antispam-PRVS: <MW4PR10MB5752F1D5317DF36DC0C44B8B8E929@MW4PR10MB5752.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sk9sB43A4IW/uKXIgJPDYpxoA8fXEYPj71Y4qMHEMrW+3gIEMV7MWztKD+b0rzaBgkHEBLD1XqK+it/XdyAnF0nA7iPeW7kf4lV9TFMHjVEAX7+Rasuz2kad42XUWkQ6GVhtqy1G9TdsxHUhF1mbMhXv2i2BOWv7aa+DQc9kzAY6bX5IU75OGPFx3+hRat+PDzB3anz0Nt3i/35dwi9V4CO4N52MjJzhCr7TboFtznRXwua2yn8qn6bamnvc+HrVjWT9fIs2rM7Wf5Im3XOC1/vzOXjZpNdT+gncSileEIUH+Ar6+/Wmrr656zSSsSb/wT7INfvCXSvkJBJXAMTx8jBOIHorKdSTlEIFbF9Gp27Zr0h+6jLpQGvoS7ko1aa+UOtLBYMV7blt/fmc2zNywwiqwVOwI5vgXbebCRMYYDewKDk7BZsAA7VSLPeoVuVoLCT5zOHvgetCY9ubnEFH5QZTuE3+dHjc/QV/qJnqbzPaxew0xebq4vDiIeMM3NCyqRk+KiuuI7wdVH71VT63Uyc4haPYd9mI2T6pVzo9eCxJN3rxUfYPrDEn553DY5ZKCk34R8Lvwu0SRywfXVReunLu6G6gSQnIcnoeFdfd0KgRCFWzOUFlJmuuqbv4cV5JvXzhchev+rRRJnhi7vb/SKm4eGoGd/pyjDby9cb5qvHRlF6eS1hLGhpxwUAM8KJGNqpKlYRw36zqekOJEg+qlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(956004)(38350700002)(66556008)(4326008)(55016002)(33656002)(33716001)(558084003)(38100700002)(44832011)(6666004)(26005)(86362001)(508600001)(66946007)(2906002)(9576002)(52116002)(5660300002)(6496006)(54906003)(110136005)(8676002)(8936002)(66476007)(316002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lq4gN17IAc/760/Dgwd+1O8xM/VfqbtXkHTF0FMms+1uTPrHSgg3czIDBIf3?=
 =?us-ascii?Q?0xMm9ujPdWzqBezpvt+J8MY0nWsMXK1rctlxhah3sw/ux9EwGcpemuYP8Xdj?=
 =?us-ascii?Q?2K99HdGMj8+cb5j9hIYd3NTGcxai44SVd6b0rVfLPDy6fIdmXvjwfrhNoP9e?=
 =?us-ascii?Q?YilNzOEhTLxBqeIFqF6sUwzBZMmVlNOej5rnrjEJCmIhN24qf9YBDvPfMeKU?=
 =?us-ascii?Q?fW9Bw1As6qnqfkXHaq+SNfmTiT2bo9t9UyZiNdigGQVIU/RWktXkmcylzXH2?=
 =?us-ascii?Q?5cHoqjSEtCmUMP5saamE7Hoq8Dfpnen1Z9NqxM9dPnChJRD9i/w9v4OirkHo?=
 =?us-ascii?Q?IDd3cPNjAFn15EDQ1SLnBCjwVbpINJkByQVYSu8yyVFavjh6dAuRLPyLMYDV?=
 =?us-ascii?Q?ykzt4pSOMqKlVsgz0g3BhlY3/AsAywDdwxnKRpwvP/aMHP+5ZmDn6NQwnGZ4?=
 =?us-ascii?Q?fBCYU0d3Rn0+knze5EtWupoSf27Mv9F+GpldVJTR5P7xY+64QAOPdaH95v83?=
 =?us-ascii?Q?FxBk7jUUUta1CLDJ607XuTgJLhjnd6F4Tscu9RY/AAPfyVMFcQgpU7jECSOk?=
 =?us-ascii?Q?A2nKGmpucsPu+FZ6M7bU1/C3Ho1qOe40wpJA44CDcrj9dFWoCUwjoE8WR07s?=
 =?us-ascii?Q?AzdgIRl5e6PysS+lJ+2m7AynI+4xIl6pffKHC77ysc3SbGSTVxDynI6bRZXD?=
 =?us-ascii?Q?dUWmpI9i0/ScJsGIEodvURk9bfbep+N1U3JrY3qtDGwOmOjQEs6ETBMdvk2e?=
 =?us-ascii?Q?GhpctKXx6MFV4522NpNtL3IF0f5McShSU/dpfgscA3wTAhwrkiTkyCJ/kqti?=
 =?us-ascii?Q?0gpaDorOuox2lCvtFzxPjuL62huhrTKwbrLWwKLqZMVL0Tah4P5jaOExsxbG?=
 =?us-ascii?Q?+vs19bhKmCW0j/PeTx+LEZY0teybkFveeQieKp3/fA+BFSCT6YwYAOT60zZD?=
 =?us-ascii?Q?lZf8NCH4H2ZLRvoaIz5jDRfRqEhKQywEV3+Ju/gtyXnVv6lfp97O3P2krc4s?=
 =?us-ascii?Q?X3SCvv3oFx0Q3vXdZFuI2vVvX0rUvjFSdGaoD/WVgt+c8id/4xhKJPXMzZKR?=
 =?us-ascii?Q?x8BDANWKs0KkO6n2OsP5Ax+no4nbBe5KYFLaaDLYdtSpIgY5Z63u4hbAv46q?=
 =?us-ascii?Q?YpCpzFE5RGpVbRvedWVEB878eVSIbboxKYeNJJgFqe1CwS/tCE0Dozadt8kt?=
 =?us-ascii?Q?WJiQlCeyjWHsd0+KZaCLZZQR3MjtDpCJnQwpcaPkb1VXuMNHTxScbFWFzocF?=
 =?us-ascii?Q?ntkE+UOCzsU1i9tZF5SgNBLO+qJslYZkOpc/W1PlekanbPzWDiZVIez0VVR/?=
 =?us-ascii?Q?ayPBlO25bW3w2xEH0xmo+FAHlmy36WiUs3WI63U1PnkbWcyfbsu1B2rpVlFc?=
 =?us-ascii?Q?i2RQix8uc2mHEmAF00slnctG3fb7MT655/T0mulFuekNrj7iCYgf6OJS+m6f?=
 =?us-ascii?Q?TBI8y61Np7T//TEHr0ih1FgX+83LeP37+Pz7u+4SoxNyx9HxWQzg0NKrtyJv?=
 =?us-ascii?Q?KeHwOAQfI94XlPxdqPsMBA1ylG+tdfJc4TmaF8CBwCskHNWhR5l8J2PmpuoH?=
 =?us-ascii?Q?WhTOwTMXPr9IC3bSBCQmlSgMLi4GUJLyt7ifEs0wlQ+vg+k8S7ofzTjVrkUr?=
 =?us-ascii?Q?6vGdkJcRWApy1pvQUK7SHZfwVm0GtwH7oZl6OmLMKgxIDoqSjfLiLqARCCr2?=
 =?us-ascii?Q?sJrmVF7PErnqmnKMfGDfstPzFXs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e066bc-70f4-43d6-0536-08d9a3764ccf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 11:44:34.0949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJBhQ/IT+rYUu4xwdn6rgI2sO0kpst3l3KdY9YJtAWCbqxxJRcHAJW8SL1knTiLSwpgni9hY5w7hLEvL039Vv9djIKIQn36sPpsSiZalZGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5752
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=745
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111090070
X-Proofpoint-ORIG-GUID: w6I-sYme4pnShXctNM785DxET0t5FWW4
X-Proofpoint-GUID: w6I-sYme4pnShXctNM785DxET0t5FWW4
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Grr...  I didn't mean to put net-next in the Subject or Cc Jakub.
Sorry about that.  This isn't a net/ thing.

regards,
dan carpenter

