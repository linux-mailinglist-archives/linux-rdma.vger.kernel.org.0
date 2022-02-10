Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A544B03D4
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 04:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiBJDRJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 22:17:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiBJDRI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 22:17:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE61EAEB;
        Wed,  9 Feb 2022 19:17:10 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21A0MxVH013360;
        Thu, 10 Feb 2022 00:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=Ek930C7I5E0EEhHKn/ITKWb6173HgY68jvVvULLROuo=;
 b=xba+qFDgCiB76kXZJkDPRRj5cqiEwiK5h4ZXbQhJ2vlBL1kQsK5jOPehQ3sAfTx+c3uk
 HPgW2VMJG4ZGu/GRcJdechEsVhzM5fT604DhTrXW9GD4Ywg05DEIvRqAlIxuu/GA0NpC
 B4KD/EWxE1NeR0d+JhcgiJcpCwqCd+jOauiVEsVf1xssiYWuPwJPREUT6zDbrqL5Tqs9
 4SgYNadcww7ZonoMmkKUgYd31GdCYWYSV1/9hGFB8SAPlC5LOQfq03w0mXfmDWNjMBnD
 fpFDKtPtdfsMFaJlxtP/PxY5lrRlrCRLcA4dyUU5zRatLYUeO6CHfiP5Zkv4xvMK13JM ZQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e368tydgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 00:34:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21A0Fqjp108705;
        Thu, 10 Feb 2022 00:34:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3030.oracle.com with ESMTP id 3e1ec3p5n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 00:34:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjwGlB+YyuuDGYRAVX6UDCyt3YKx8Xa8KcZbM09CotsmT1StHtcVL/CqxlP+vju2c5I5+wjipmRgpI9gr8PfczcvcWkpzH8oMA5wiJZncW0+GsCxOaS2dXgCX2Y3A74s6zlPKiZEMwxQSeIlwJNLwjEGrNDmE8rtxnu3TrQEPNA+fsZ0hcQnFyk/VBc68keQbr3ZhFU3LHY6E2sRUS/tOGVzL+muloPfOi6e7lDLCyayJr93/suUdb0Y7NWBAnEn5Ezdng8HSfGn6bR23JzGxjKzHjxP/tC1henyta/jyFzGnLJRVStPDDvXrnKuASQ8rXK65YfvulITDINr+KUmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ek930C7I5E0EEhHKn/ITKWb6173HgY68jvVvULLROuo=;
 b=NzTPYkam2kAIHlhx4hz8tVA4NzdSsdFJlbHiZ7a8fznj3yUsZXvZ/UAM+VX1lVMep6JprONlGVAGpxCmUw6llTUBcSWaf1t1HH7l9LQD3mgyvjStF7vOagLg4nGltAZ3eVyE7lsypDcuQ5u+lpgxVv4L3tD/0lmyD8SKD6DUN6P32an5z6wzKVm8B5yHFzfHgnVdUgbOlxCatqm77dqv7a713uUtN8HGvsCMQgNDJ/KQQzDFpvNAWE1T0hHSjuqQ18/0MCXqrGlnkPjQrjUsj5eVEFDWZ0+g87hAFIwN6vWsA+Ii+hkY2b/AEiat5bc180uh1aMjm8WDxQ45M8unvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek930C7I5E0EEhHKn/ITKWb6173HgY68jvVvULLROuo=;
 b=qwCrdKTs5iVFCQsm0pbYloniyVPxkwNZVhaE1Gv0E6sTuFgXZA6k4kmrCFNeB7z+26i0P5leSow5/bRoWJ2XHjChBgTQWjTNpfNLtAhQKAnKAbDSnpH1CYJvuf5BQYJssVKc/WGILtTykNna334/UQCkXWYg1YoJxCCH9FgIEzY=
Received: from PH0PR10MB4472.namprd10.prod.outlook.com (2603:10b6:510:30::13)
 by SN6PR10MB3039.namprd10.prod.outlook.com (2603:10b6:805:d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 10 Feb
 2022 00:34:02 +0000
Received: from PH0PR10MB4472.namprd10.prod.outlook.com
 ([fe80::94eb:56d8:7cd8:ca76]) by PH0PR10MB4472.namprd10.prod.outlook.com
 ([fe80::94eb:56d8:7cd8:ca76%5]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 00:34:01 +0000
From:   Victor Erminpour <victor.erminpour@oracle.com>
To:     mustafa.ismail@intel.com
Cc:     shiraz.saleem@intel.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        victor.erminpour@oracle.com
Subject: [PATCH] RDMA/irdma: Fix GCC 12 warning
Date:   Wed,  9 Feb 2022 16:33:55 -0800
Message-Id: <1644453235-1437-1-git-send-email-victor.erminpour@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0188.namprd05.prod.outlook.com
 (2603:10b6:a03:330::13) To PH0PR10MB4472.namprd10.prod.outlook.com
 (2603:10b6:510:30::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c05896-1006-444c-ac91-08d9ec2d08df
X-MS-TrafficTypeDiagnostic: SN6PR10MB3039:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB303945934E5B8A12C1323610FD2F9@SN6PR10MB3039.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N10n4j78sojey67qlXzzRsbwaS3m9w5fCpzEBz18yAKn3SHuoDmkKDL9H8GpCHeAfD2qtaxCf0UymYk/ojPYUR4gCFGmMYDwcrHAJWbOq08Utfc74kM/7FGDwPuiL29CVrCpztyDgwDqYeA/ppaHWpt07qVDY2gtzoa9UIjzTNIoBcdZvRiES2NINeqJxd2hAg2OOjF+Irpq873N71ap8jDA+L2wa9qZyOWAjSzwOn/uoZKXf0Hk/G7SG4zUj5MgYSMpTaydVRnLdqp39+Ux5OcNxpO39tl4fgIHme+fqKIRv2fjMqLegmbBH1PND3347m+e/bLyys24bORASSkwQ6Oh2EzhhyRKWAc2ymh7w9FOzUcZNtmSFuNE3EjD0TfdvEA7O1psblMG2NWjRMs7iusR9lPatR/n0ts+i6dq6Oe5BvAyZiTjshyO8mFySX1ofBoKnpoX8htyKAkX50RbA+sYPbiSsj4MW+NANSAMbKIiDRnaN8LqjhTUB1gzTw6qklxYPNgt71PxiEY6qTki20vJWpOigUuammeiWWEIcSV3lSDEZS6aifMNIC6/JPJnf2SxeUrSRZHjAwxksMuvHdWzVdxAvZIePSNUlclOOLKjOTBDoCOkc1zsagdXo9K7MFBWXXF2NaMPFpOKUL0l+/m+8l8kXZ46HH3np0SoJxDsRB4Uy7FSvLQGkUr2OOxPlDCAL7F02Gg4w6mIdWIA3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4472.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(38350700002)(186003)(316002)(6666004)(6506007)(6512007)(508600001)(86362001)(6486002)(26005)(107886003)(52116002)(4326008)(38100700002)(66476007)(5660300002)(2906002)(44832011)(66556008)(66946007)(83380400001)(36756003)(8936002)(2616005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kuYKAcj8vcblJBwWpegnXpNdpVd71j/B84OMeW5Q2ku2Y/a3xGAKumvu33zL?=
 =?us-ascii?Q?MO4qjEwCgDwG6nJsJSZLnc9UuShjMPc++m6O9ayvBoydB7dbK7ovsGSjKhPz?=
 =?us-ascii?Q?VuB5fAk8C6BDfwLPJiZwBvlIWbmlaEknXFUlUcmpOyjx2UcIag8BTE5rpWJu?=
 =?us-ascii?Q?HbcRAu5tEemGGilvVAxp/RthtElCxDFPmOUf+FPDb47j4Vz3UEUvAdYbFQNn?=
 =?us-ascii?Q?f2VnUBknIbjg0IG0VbxELJRvyH2W8wYSydSoA+fsmtuLktWj1nRBphbnmTvU?=
 =?us-ascii?Q?CvHiRbgeSPc06d0mVE4UYuNG2kr0aNLML9zHO1dFkGidGrh3zZEuHo/xVk/F?=
 =?us-ascii?Q?b6O/8QIzK24a6B3JVh3gQDiHM5GwPhTH7LxbZMxemRlYJfZs4+xQcc7cRDoy?=
 =?us-ascii?Q?7mRk1RhXVb+CPCNSCm5F+c0fmcl8VcsdivujbnV3pGfSBbztVvTuw8AB0tGz?=
 =?us-ascii?Q?tp6cXNx4YkaLpBfQDFz15ZA+DZThib0xOzJe+v728rvO8d/6TmrxIgy8c4c4?=
 =?us-ascii?Q?Moxwj6S8wZ3u33MftayEM2BfghQxMNB3Vwdf7B4YdzwEjL+/P0lvgn8AJAjk?=
 =?us-ascii?Q?68w8L8Agiqrb/E2VHaVBHBIb3j/j05DeYWeW05mTarzOkMScYKBOKOm7M46u?=
 =?us-ascii?Q?oRjE8O6tBioscKDhivUm2Ss7CGPNxJl6Y4YDnc7f7PgJTTM0swPYjRyrujqa?=
 =?us-ascii?Q?vOK8YFlsNvA+Fo2El+WmhWj6Zpz6P5ufHquEyUxfO73uTWEecsdFB0eEklHm?=
 =?us-ascii?Q?11q0Bb8Tkd7KP0Ng/I0hjO22EGu+H/R3yoHi5f2hvXOM1L/Lm6jcHhgHWh5s?=
 =?us-ascii?Q?8eLN78NAhz+wvHrqaltdCkBPPOdCcMQ2M0ejr+AJfvvwHtN3murvZTYLztwH?=
 =?us-ascii?Q?8HeUz/XREHKnWC62T0C5sBvIgbT18zerJqBv3E0JGCKu309Jp/KdvsdFygwV?=
 =?us-ascii?Q?TmDncLHNMjwUoEIUtxqqNTW1MkPWHuvyhWFxXtIjrcI3pqY31XaOGhIaxpmR?=
 =?us-ascii?Q?2LxPMg/tPqqY0NG64MMt6rM6fNTvH+xd47snMY2TzwcDIvXNdkGWwT0hbNx2?=
 =?us-ascii?Q?CB6zpuliDVkO3GK+ACAeQRgmlc9KPqPDq5k2RrsguTyk1pftQ7ZVZQlUJ3hd?=
 =?us-ascii?Q?tMhpT4aiCD8cEbf3Zp/Y7A5m3foa0sZwPzUwcGOYaqAABiI7lslQqVyMyS89?=
 =?us-ascii?Q?f5Jd5EoPH+Mu5S2PPmEJNfdmt95wJr+m5ysrWMyqbmqd+r79zCLC5+BJ1LPc?=
 =?us-ascii?Q?DnmcXzttitoVrRKTMTQsbwTza+ezFyJ+Eyiz8XZewU/eR9NZOijn+Rci7nIZ?=
 =?us-ascii?Q?kmj3NEy+vLFb5tCEaHAUplwpDy74ZTr0qm7EY2jVmvIiN+Hj65hrioHg6tt8?=
 =?us-ascii?Q?bi/1qiAXv+s9s2d0pSDlceL0aScqaofZx5VKZgDuVpRpqMICklpMNJ/yrEQ+?=
 =?us-ascii?Q?tRuvPAmr9JzfzuU9S2VMG34P3IZNVSuguysde/vBUkYqnhsSxUcEjCWevzAe?=
 =?us-ascii?Q?pN9g6UcNr+7s1iCP+k50xJEm8MVEguSvHuPeBUMLM1zt8bgLWauWcCP7tmC5?=
 =?us-ascii?Q?NlTihy8XVl/JS18cv1zbqrO2MzJmWSxxQMM14xDaIyTUqTJBc7+AO0nH88bL?=
 =?us-ascii?Q?5KIJrGaEOf39wsezSYerj1LsiOIXeXwSS8qfffSYwdxbpt+wZTiBGuiQRZ/V?=
 =?us-ascii?Q?DQKzMg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c05896-1006-444c-ac91-08d9ec2d08df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4472.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 00:34:01.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGn668fCro5kRF15GMUrrsDLHCZyrp0e8s1fZWiKXKgfDidHF0sIZZkLapsRuWfRKYHWSw9aKaOmSvGU1R/AT2ZTEuJW/jicDlWkJ/8D0ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3039
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100000
X-Proofpoint-ORIG-GUID: 1fCCKkKfLWSK3EHIMbaFj8ybzvZ6U1h9
X-Proofpoint-GUID: 1fCCKkKfLWSK3EHIMbaFj8ybzvZ6U1h9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When building with automatic stack variable initialization, GCC 12
complains about variables defined outside of switch case statements.
Move the variable into the case that uses it, which silences the warning:

./drivers/infiniband/hw/irdma/hw.c:270:47: error: statement will never be executed [-Werror=switch-unreachable]
  270 |                         struct irdma_cm_node *cm_node;
      |

./drivers/infiniband/hw/irdma/utils.c:1215:50: error: statement will never be executed [-Werror=switch-unreachable]
  1215 |                         struct irdma_gen_ae_info ae_info;
       |

Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
---
 drivers/infiniband/hw/irdma/hw.c    | 2 +-
 drivers/infiniband/hw/irdma/utils.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 89234d04cc65..a41a3b128d0d 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -267,8 +267,8 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 		}
 
 		switch (info->ae_id) {
-			struct irdma_cm_node *cm_node;
 		case IRDMA_AE_LLP_CONNECTION_ESTABLISHED:
+			struct irdma_cm_node *cm_node;
 			cm_node = iwqp->cm_node;
 			if (cm_node->accept_pend) {
 				atomic_dec(&cm_node->listener->pend_accepts_cnt);
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 398736d8c78a..16b65a6c7db1 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1212,12 +1212,12 @@ enum irdma_status_code irdma_hw_modify_qp(struct irdma_device *iwdev,
 			return status;
 
 		switch (m_info->next_iwarp_state) {
-			struct irdma_gen_ae_info ae_info;
 
 		case IRDMA_QP_STATE_RTS:
 		case IRDMA_QP_STATE_IDLE:
 		case IRDMA_QP_STATE_TERMINATE:
 		case IRDMA_QP_STATE_CLOSING:
+			struct irdma_gen_ae_info ae_info;
 			if (info->curr_iwarp_state == IRDMA_QP_STATE_IDLE)
 				irdma_send_reset(iwqp->cm_node);
 			else
