Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EA23ABBBC
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 20:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhFQS2e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 14:28:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8256 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233583AbhFQS1r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Jun 2021 14:27:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15HIAuLO001447;
        Thu, 17 Jun 2021 18:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=pfTdon9aIQax+YZQqaQroIeVH2jr8MXWkXqvnzClUAo=;
 b=LgwL3c9uMtI/5DL5mTmDWSNpbIoUJQPfjCl6mpNEoSthfi/M7CPK9m7VbNQGHNYt6VzM
 eemqKA9A5k+wHjHYLOvSGqkMehUHiwdj8F9gvi4quwsAxMAInAdKBLepuQbTjXG6CBFT
 2E5qbed/j47HjbbBTYo0E3pcj4yWXKTk72BKqQE3j/CO1Uys2xCfiG6FLZI5pfpOtMwr
 l5Bvwe7lH2KlO62r2WNg8SsGKL3zz5MpdXKcgiWwXhenz/uasryrk/iWMVXUZAZksx35
 LyTxsmYHilhK2flLkD3NsRTcJLOnIWSB7pbiO33pins2F/yqUYYH40tBMKzzU2zdGIIh 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 397w1y1q3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 18:25:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15HIPZFr125130;
        Thu, 17 Jun 2021 18:25:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by userp3020.oracle.com with ESMTP id 396waxxj8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jun 2021 18:25:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKE6nFsTax+gT58ZfkicV6AREYBY0XI01m41TcWwokQiAkE76jpVvWCYFqY6bKmjeoce9HUzWnR3vnDeT4BoNx+DYnRJLfiDHixNA9lmeUXFRV8gGwTd2Chd2XOHFfJngiGsN73piycNnUl77PxNY4TyQ1Mg5k0XW0TBlStVNWUWdofA86ZuQo8joJEjymhfkzDC0ShPAubomicNS4Wro+33+G3yTm+5MB4slQPsgRnjEPODebnkOJRcrAXMii+mR/eTQled6Slh0RaiN9L9WiHi1TEguNV0YsUkGJZotyQejiiGx6ATJtwEFwuyJ+aUrYFsOFcD/ozlqWs6gz7vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfTdon9aIQax+YZQqaQroIeVH2jr8MXWkXqvnzClUAo=;
 b=gRMdoHGdTHfRKtIFCL+ZF41GwBPZFm5qGp6y7crtTNhNVEA4kfEv6exskt5h0A8JkSvHPEeO1KMwAOjzk/Zb5eAePVg8yDT3MCGt4+6/oCIMp65PZmhyzHWdwZbsCp87b2JZ8xRZFyaYZMkIOsbm6IJpA8NIj6DgjUjkCJ95nP0vs6hbIdMNhztZk9QDolPaRjzXJFFkqK0VxCd3ePB2j5W6ErzXXgRdFuKiVUnqsby1tqZB8INkOySYwvaJ3lGTp62wY3MN9NFM4jM3elHZjaXdEoaISk+OBDsgA+FSh+D+jG+ldnMBmUokeddyrRT4cP0AfO6XF6ikzmjyn3fLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfTdon9aIQax+YZQqaQroIeVH2jr8MXWkXqvnzClUAo=;
 b=jncfzDyAV9MjfO3w+lAJj5nLbSOynToaRHUt2weGf7oRPe0YgSTS+atSTqwV68ZdZmlKbi4AUQthnASvBg9xu5ww737aevVBMfuSqkHaJLQCOV3BC9Rx2epLTCRTgnzg4BJhJteLCp/+cqBKzFWlFX3i4e08eOcD5i3dGC8JmxU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 18:25:21 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd%3]) with mapi id 15.20.4219.024; Thu, 17 Jun 2021
 18:25:21 +0000
From:   Rao Shoaib <Rao.Shoaib@oracle.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     rao.shoaib@oracle.com
Subject: [PATCH v1 2/3] RDMA/rxe: Increase value of RXE_MAX_SRQ
Date:   Thu, 17 Jun 2021 11:25:10 -0700
Message-Id: <20210617182511.1257629-2-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SN7PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:806:121::29) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shoaib-laptop.us.oracle.com (2606:b400:8301:1010::16aa) by SN7PR04CA0084.namprd04.prod.outlook.com (2603:10b6:806:121::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Thu, 17 Jun 2021 18:25:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03579d67-40b2-429e-9988-08d931bd4430
X-MS-TrafficTypeDiagnostic: BY5PR10MB4131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4131059F98D75CBBE5A5758AEF0E9@BY5PR10MB4131.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dr5jMJ+1ik3Ujp10nbfuFg/o+5YX1AEIeAGsRviX1AJHLNBhuEm4SoLolebAi7q4KrQZOyAYEEMumX3ddNIhrYtYVtTFUuL9DS5dPk0e9VS7UDumhwE4zHCdZ+I0CEy4idRGKSJ08YusJMKpPXltM4GLLf5ep0lBXLkk6BYzSkzxJ1VRooTJtwGRnoGBlK4VjwmD7SZxs60vqYh//4SUFztKvIteWNHBIeZSpaG0tmz+QmXGgQms6ahcNxWY1z6/dKpjWqPq+/BGyQqFSOSgsiFLBQ4oXWnrjrTZvulRli3ub//vTlVZPznBo+J5YF9SyLc1hIuwk5lZbkBFUIcnUiRciRfHCz6I6KiWIGlGvcaNNkEv8hhkIQD2N9Z/7hPSa2QjAUgSHqKueIdJ02EWa8oV4Auf7T26HLq0L2AJsmzjZ+BtllxoXtDrgGxXFDlXF6zIAyg9SPz/fqoDRMsl6fDByY4NkqP/6+McGsct8SlYzuQSEN8/qwQQtILAQkZNHmHHzTC3pG1GTFGARhc178CIkLFy/OvbbuLHQkjLtKKeA3CV4cp2L/zmEuHDeFU/uVm+4IaUcURL2Y6u4/YZ6H6Xf4jznXVRMIEzeV5hD6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(396003)(366004)(107886003)(5660300002)(6666004)(186003)(2906002)(16526019)(2616005)(4326008)(7696005)(52116002)(83380400001)(4744005)(38100700002)(86362001)(8936002)(36756003)(66476007)(66946007)(6486002)(66556008)(1076003)(478600001)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a0U06w3xAHutvQBac5FscHge930zroZ8oS9bqs+cp6Z5eBcbpcJwM4I0As18?=
 =?us-ascii?Q?m8ty2E0gCufT/niy6suXwuQQGCIecOjXvtOXEzKroU/dgI3S7dHA+ZAHcKSC?=
 =?us-ascii?Q?7LmTrrcsNJ9Q2bYCR3BRa9DSeuL9cb25YxOqyFpDAQxnF8SdialvLGfqBDtO?=
 =?us-ascii?Q?gHtQGzvxU6WWHWf4HEHVPVM5pXh2oLZQcgwRkt6eLrY5nmmJyVBEpIiLniZg?=
 =?us-ascii?Q?/24dl4T9v7dCmm3yOCOl5h2YnmX8upVYONHIUSzSRAuWQKGB+h8AU36Ui7ph?=
 =?us-ascii?Q?BgPkby4+f2nJKEwpxwutOSGrvF6LG9mUBV4oIQaYZYOVfraLaDPSUkvm7gyi?=
 =?us-ascii?Q?gzBfzJzuHoq0ddGLv+iTbLQ04lFnkM/9Ww7yRkamNBoOYdJPCGB8hgMP5J4I?=
 =?us-ascii?Q?g+TobloJ7F7acdcUp4EnD5KhvNm27dPWhnI5Zx04ZDdUgDa+nDgzO6K6DwT4?=
 =?us-ascii?Q?gFAbnn3885ZMz1qWX6i4k6qOQfGgQNbG1MAo1EXZBy0mOycENAeuQVTEBs5u?=
 =?us-ascii?Q?2j5QM1nWOsGN9DPQGVb6+j1YnfdztM02ju1KHuOihT0A7WX9BzuJktbsrjC+?=
 =?us-ascii?Q?EShtu++mIBRaD1Zh3HKdvEIUrSXLndZjX724znjFZiGxCh6+vEYGiHMycI0b?=
 =?us-ascii?Q?aW3X9MnYJ9B6o0/Qs70WkAj4CrT84uDlLQ7keAMfQg4n3SCJZ0kQcrJdIfV8?=
 =?us-ascii?Q?rak52UKa5lR1R9nPHIDfS7o+FPOi/36fQtLwWx9eCMnmbyWy13uqLHIIQkcY?=
 =?us-ascii?Q?XNrju6y1UVG//SWcgncniGlbdzxS7VXK2iMYy1/BeFdI2f6NGAh1d0X12zPW?=
 =?us-ascii?Q?HchBuCn171EKkphLbVeBwlSomYZAEYtMCHnED1nIDjxj54maKiu5fcNIiKWi?=
 =?us-ascii?Q?3YtxmuHFjSoXuxxinDLkp0yeMiip9zmiVLvkC8ps4ezHKZ0ncmMeTSj0VINH?=
 =?us-ascii?Q?ty8y/PdPHdsGOlkoab8oRSHlkSS4u5yB1dEtURnZswKzB4rqZazKU/H6Zf7/?=
 =?us-ascii?Q?jt5AdMgjdCWnm/BqoFTkIQ+DqIqp7EcWhBZkX+LzP1ShEr92J8aGyhAXspmu?=
 =?us-ascii?Q?CYhDEiGguJWFuzor1zQcLyLKBse+PUFB+5axV7JLOiuQMWebeP9wk9x4taam?=
 =?us-ascii?Q?PRD6FchnhuKzY9n0nzdctqQpWpmq+78wcqtdh22Ls1x6xZYvLOttttMboPyn?=
 =?us-ascii?Q?+S/HvfT60g2jQVFR2RQ/sEMBCMQ1/SvKwNvivogxeUT6I25TIUjTwIPGfqYE?=
 =?us-ascii?Q?7zCwVGzmVwEVE9HjuX4GcwJDwGIboqq7dWyF1do2wizR7/0D+WhNJ0sIiOaA?=
 =?us-ascii?Q?oa67zcFB5beIvGdljGMpSB9osxdYSZzpBT3z3GlLNJv3abCv6cMjjhwTZloj?=
 =?us-ascii?Q?sqTjDX4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03579d67-40b2-429e-9988-08d931bd4430
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 18:25:21.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrNQ9aVSEDM/LfIM0Iq2dNwHz9pflJLuS+1YCyhi/FsKzyd7E8Irgp6YvayOZfEjnCcKZpmgjTticMqXxkAr8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10018 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106170115
X-Proofpoint-ORIG-GUID: Vob6OPkvdTrzZChjOhUmyRBJeXGhoStI
X-Proofpoint-GUID: Vob6OPkvdTrzZChjOhUmyRBJeXGhoStI
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

In our internal testing we have found that the
current limit is too small, this patch bumps it
up to a higher value required for our tests, which
are indicative of our customer usage.

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 2fd5af44258c..3b9b1ff4234f 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -67,7 +67,7 @@ enum rxe_device_param {
 	RXE_MAX_MCAST_QP_ATTACH		= 56,
 	RXE_MAX_TOT_MCAST_QP_ATTACH	= 0x70000,
 	RXE_MAX_AH			= 100,
-	RXE_MAX_SRQ			= 960,
+	RXE_MAX_SRQ			= 17408,
 	RXE_MAX_SRQ_WR			= 0x4000,
 	RXE_MIN_SRQ_WR			= 1,
 	RXE_MAX_SRQ_SGE			= 27,
-- 
2.31.1

