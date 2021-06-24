Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA83B365E
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 20:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhFXS6P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 14:58:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51138 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhFXS6O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 14:58:14 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OItqrg023608;
        Thu, 24 Jun 2021 18:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=UIccMQzP2yeICMmRhxpFtWRAyLmjKG9Dv3M+DwwhxJE=;
 b=DUQNomIiN7zRPt5ZNlJHOpL6d521/HOzJicQ1qSjQ/8I61TgL8nPMuhLWuoEupRip8un
 ujzlXXiB9aUdjAG7KarZInv2xzq9N1XeLyqk6h2PwDgO5buyDUcqYrgO5J8xajKYdhGo
 nvCkRkmN+puc8qxHORHhTr/kOEVicaEK3Gn3oN2jrn2XGC5M9G7hD0gJsQGHyX8w55hg
 CxDFrRlpc85ty+LBUAzp5R33fFf/u5DzBI5ThP6w7oiDiEtW0zCB9M9pGw1Oa5sh55gR
 kBpcJSbi9wOFaqQ/DPSh1KVm5IkuSH00C0CzwWUHBK0vCMV6u872kotjRk0d6sSNqYds nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39c8twas1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 18:55:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15OItlYW056802;
        Thu, 24 Jun 2021 18:55:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3030.oracle.com with ESMTP id 3996mgy658-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 18:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJQQTEKQKehtlvUkxBs7GZ3e08BUufJUorfQ0sDwU+IHehuEY1QT2ZJ1ER7yzVEwcGUl6T7In0F5iQxA/qnT6Je6U13cIfuymyOs2Qul0bUM36gVspHs9rHffAKjnHbBtOG/73vtyshohgUdg3wxApqEXsNhvdr40dfz7Kd2M5sUWhpMZJ8veFCXe8rtcIuavYs0t7DJUB+Z/jIQBlI/LGfxxSt2SRmkx5yZuJvNwHVh/7zJyjs9RceRuVgOl/B8VK3aI1FgqSIxWgky4BaJ5eGtqeCSRQLGQNN1jjOG+6g7ingqNVaGHrO6zUx8r8HLIWrBQHWnU0Q0SKNasH5f7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIccMQzP2yeICMmRhxpFtWRAyLmjKG9Dv3M+DwwhxJE=;
 b=PDL/y+dOuV1UOr6BiovA4qdTebKxRAPgtf7BGv1lHOXqCn7DUDQ2/01qEFZITClpOBSh21J6lUArASlLOouPBOJAIWq15F2ZpQHl+ZLPvuCIxARYvbuF2C7lvqtbDsVOXyNGme1MOwk+Y5ler5Ot2jmzxQOVgUadlxtdphOVU6cyDbEL+g8ZIagnsYKjng2atk2n8/Hq+iFhH/JF+7pRwMvXdBqLvt69uA8mSreCTw17SDnovEQ3gADEAH0xvYtakvZ2BCjyxktD0B2nuz8+sy5F6Ay24bmboCHkTtxkE273gULbV8M242hOvaS0VxEbfYLyo0xdrxxcpAJki/hQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIccMQzP2yeICMmRhxpFtWRAyLmjKG9Dv3M+DwwhxJE=;
 b=W3sefUws6ksoG3fi5xCvNgGsq/KeYdVsf8W/AZ1L38t31v9q3aGdzD9CrYTzflPaRzhJQdMguJwol4lVVYYPhQsd4zqqvK53LLWuOSEvHOYNJ5Z1U7mnkCimyKxYm9aJe0wRQYkELeJNtZ+6uyMGKIbarSDx7BgV5xhkdtMCKeY=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3158.namprd10.prod.outlook.com (2603:10b6:a03:15d::23)
 by BYAPR10MB3253.namprd10.prod.outlook.com (2603:10b6:a03:154::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 18:55:37 +0000
Received: from BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::3c6b:8429:3eb3:6559]) by BYAPR10MB3158.namprd10.prod.outlook.com
 ([fe80::3c6b:8429:3eb3:6559%4]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 18:55:37 +0000
From:   Gerd Rausch <gerd.rausch@oracle.com>
Subject: [PATCH 1/1] RDMA/cma: Fix rdma_resolve_route memory leak
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Message-ID: <f6662b7b-bdb7-2706-1e12-47c61d3474b6@oracle.com>
Date:   Thu, 24 Jun 2021 11:55:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2405:ba00:8000:1021::1046]
X-ClientProxiedBy: SN7PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:806:f2::10) To BYAPR10MB3158.namprd10.prod.outlook.com
 (2603:10b6:a03:15d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ib0.gerd.us.oracle.com (2405:ba00:8000:1021::1046) by SN7PR04CA0005.namprd04.prod.outlook.com (2603:10b6:806:f2::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Thu, 24 Jun 2021 18:55:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f26382e6-711d-44a1-aeae-08d93741a77f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3253:
X-Microsoft-Antispam-PRVS: <BYAPR10MB325373EAEFBE8544D9D5699C87079@BYAPR10MB3253.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjGy2xJlHf21uOvUf6YM6FS0pINaG7F0DcFx2mmZU5zeVFyVNjJPxbkd1uVq6gPdezevGzTTBZBD8N9/NQGMJEjTH4GhDw2UfxQpFWpACaA2J4bCButfCLy9JdakXCu86pC5r3cu2bHURg+bXb3fsifDhXURTx/d6LkrLEP1t5Ha8i8NTugIW3jc+M8Iv9OGU/s/eugEQ6NfE7mFSrOTlyagVLTpfCruCangb6EDOren3IzcNS89809AZ7TusGL/MtFa9uW2FZEXRudBR70nrO5Cw3ijuCxHZ2sRl2cap02oIkUCEHUi4ClPZNjLGX2695Lk7ppAuaImhFC5+CF80PDsNBI5bQMKaoKjj/WENOt9jUewEN60qG9EwBBfe8Tjb2yvU8Ac6/MXkEDeDXNXQkGEdv2ukVjD9UvzapHq/mYqGveC0KLd7tD+b+ifC4FZupcZpMjLTEursCo3E9uK1rmJhdtbnnKTil2KLX1iu3J6F/TT7qA7RVygSHy2LiSfCZuaRQSbuCjnK3TKQUdLxIcq4dwfgNHCE90FuCyUG+kV5BYSdjMSjhoM97ndoSj6u/LjqCVvbCyVHg4PUqAeoR0HYkP3k6aEv0slXzrUI8pezqQN/QWvAevnJQ2GZrN71pWm7P2n3DTGrrJgbd4T8mFBhqH46Mt6lQOy4qp3mpphFwT+tlsMo8t7S+SeO6IK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3158.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(366004)(66556008)(316002)(66476007)(8676002)(186003)(16526019)(8936002)(44832011)(110136005)(38100700002)(66946007)(36756003)(7696005)(52116002)(86362001)(478600001)(2906002)(5660300002)(4744005)(6486002)(6666004)(83380400001)(31696002)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?Xk68ug6JuqtT6kttBc6kSYkrpQcvYwn2ktEr4CEtJdo3XZO8/4tVuor0?=
 =?Windows-1252?Q?4+zs+ZsXQa3HyqpZzk+WPdxsHP1mwHeFNwsDKyg54luCh6SzI+zg+0wY?=
 =?Windows-1252?Q?1fRrnNX/BRSR9hXxQAKGi4OU+VU0O+icvRugxWrv0AZtX55IdwhISD9u?=
 =?Windows-1252?Q?gDXJpcT2LyfFSlQrGLHYQy7Xdkgfx67s5Cj4hnhUHjiHPD0nkaRJN34d?=
 =?Windows-1252?Q?jNvlZ99J6AB8NbQec1U+zLAoeSA1DtmP1ipG9L2jxvSf9H72XedM1nda?=
 =?Windows-1252?Q?I2nClkws+NlHQgeUwZFsN4RjAZ4PS6DWn0yUHGUXSE8gTCTJx1Yfxvpj?=
 =?Windows-1252?Q?Veaq4K74BKt7gP7ENZ9ooi1NNe2Pc6BW67M+r3YDkgch7U7Dh2hh4hJR?=
 =?Windows-1252?Q?pe7C31Jr4RUddAhXIQBauPi04PQw0PxTAZxOaNsPjvBRHVaWKDG2V+aU?=
 =?Windows-1252?Q?JIN1tkdY7pZo/sk0sTKyTjajgdPy6E97BIVuz3a3LJ23iUG+yxXiVEU2?=
 =?Windows-1252?Q?RfclQuczrCeK4EhSBFPRQ7SBpdD9AWPUXBl+rhDWY+PZEIjslanUjzyr?=
 =?Windows-1252?Q?XMgKxDWwfIcbnyBYhShQULBK1boV3XuZaffdk8pZWWC4WrAfZYvy8IUT?=
 =?Windows-1252?Q?UizNqxolQtU7soqI2vmDK87n221zr1gHPtRNEurrXJ3XFLedcQtXXlxx?=
 =?Windows-1252?Q?WqZSpDD7B8pIC552rxfqzdcmIe/dklOWk3NVjVq83aBWeg2AEpcYlEni?=
 =?Windows-1252?Q?vqio2e4dDaSrY7QquDckD0Mj0gRLLFc6QBWtHGV1MWDpVa6RExK3k0of?=
 =?Windows-1252?Q?dqudfqekh9ql2wZJ+ArH2NKqg6VVjaWqXh6kDkR15z6C3iyIn/l5Pdkl?=
 =?Windows-1252?Q?vG+Q+XCyEyQv14snBnlS0M73cFlDXKUVJdk7ozoJRAgn6hV/bHIGTyJr?=
 =?Windows-1252?Q?vEBBsdlY0k99Jl/9fhUY7NaYYldanE4ewZTRdMKn78KAaP14IqPNOhwU?=
 =?Windows-1252?Q?jHGIUAZ+dRtnrQ8nYqtP8tkixDtTD3Dw2lFblCuw22/7lY8P8VlFMGpn?=
 =?Windows-1252?Q?btCyoqLlnybAxyAxXlYUHOwYQtwoaQ1FXd87IqJSMyfQuVi0r5Mndi8X?=
 =?Windows-1252?Q?miwTo0tmB9oF/PDpmIsnsDRZTsleXFwe3K985tFBJDEL4DMaZ/usEkbx?=
 =?Windows-1252?Q?yQlXm6M0krTiXE8W18nogGKHw47g0G1N6//KYUCqX5QOINLhwohbCEn2?=
 =?Windows-1252?Q?2BDTKhpAp+Lxys43zfRpCjd+PuqxvTWiIe3CMrX2J1O8LVH/yEIqaIjI?=
 =?Windows-1252?Q?X6ovssglprEGlHMdFSGAaBVFIaxKjnosrFOSbISEE5ChVofWyWLtdX64?=
 =?Windows-1252?Q?h0TPAAhn+Q+ge0WGn3TX2OkNRdQUAmUloFi8Lj7L8rdLjzsC+5/saJB1?=
 =?Windows-1252?Q?QZC/x6XvR6pW5bN9u6i1UDForRxxcVhl4ih86EMYaog=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26382e6-711d-44a1-aeae-08d93741a77f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3158.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 18:55:37.3499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKDEXaFVs5+4mo1wm+cZ5+LQlkZCfG51QzxBiU4gaUq4IzNwLQYn1M6pCDA8ezKLLr/zSzLvG5th3cxTmhlkUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3253
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106240104
X-Proofpoint-ORIG-GUID: Fpik3jeji1AkRibb3aTMMQOmCibuW_Sc
X-Proofpoint-GUID: Fpik3jeji1AkRibb3aTMMQOmCibuW_Sc
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix a memory leak when "rmda_resolve_route" is called
more than once on the same "rdma_cm_id".

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
---
 drivers/infiniband/core/cma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index ab148a696c0c..4a76d5b4163e 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2819,7 +2819,8 @@ static int cma_resolve_ib_route(struct rdma_id_private *id_priv,
 
 	cma_init_resolve_route_work(work, id_priv);
 
-	route->path_rec = kmalloc(sizeof *route->path_rec, GFP_KERNEL);
+	if (!route->path_rec)
+		route->path_rec = kmalloc(sizeof *route->path_rec, GFP_KERNEL);
 	if (!route->path_rec) {
 		ret = -ENOMEM;
 		goto err1;
-- 
2.24.1

