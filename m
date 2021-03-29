Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA20534D1CD
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhC2NuU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:50:20 -0400
Received: from mail-bn7nam10on2111.outbound.protection.outlook.com ([40.107.92.111]:22113
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231448AbhC2Ntv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:49:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLBcAdwkvl3HytbWzc1gy2MkSUZvBzh2vUGvGHRaKLJxe1PuFrp/6991HU9TcfkfF7AkJS5eA/WvQtBCztWeX0IqG7PCl+r3oUAB1TI3r7tbspJdMNdQjglSWyHFjEWQ2U0I1BtEP34Jsfbvnf7fSJsFiNNr4O85bNXm6AW9c3VcZc2MSGvR0Yxx29BiGpSGL1tC/aBhXoF80Oz913iDm+6zQuz3ty2wLAWhD46dqpxmrLmtH/CKDr3xdyPoAlE6kOfjXR3nQvsjz50ORpUUR3ZKweIMnaVQ+nyGOez/cfmQEXibpYT31vuIXq/B5EiVEYrhmvh4msLIW8oP7iWxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46r6J9wgNIyTDQm75thjv0246xhZrd8q77MZJhXmTVc=;
 b=bbtImfsQucaFLvy0RJdia7Tx0SqqDwPe7SS/QBLUIt2raN75Q8k4YFiRu3uXK7xvnTYJ7cxBYyx8aGIRqhDKtVlHLchR58ZVMSy5/AiKigNd8+YTBSJKtRCFvNedaO2gNQRtsUxz9EKcBF++KkdHbbpQMNnCPxustq69FjNnC/ChhcWBehUWVLABETKVzrE2NYhEalKZeWO8n8GgtNh3PxetnPH/mVhmt+9dzcTJHdAygMQEjwYnYt7uXaeGfZe1atHUp8uwUmYNYwOoQl0Vg21+3mV8JNuqvRVYverFLZTbh7mHVDzsViSqzzF+J/Yy0hBzLAiYId4GH5NGMjmDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46r6J9wgNIyTDQm75thjv0246xhZrd8q77MZJhXmTVc=;
 b=cDLFw7G8jC0vl2F2Bs6Z7cl+FZTLP1mXNHXr5lckEKzvCaWdDqVq8u6FOFEbvSXAC82eGv+sdt7T1nUqr4BEzWZYd3hebiY2pdSY2tK2u2OLzZfi/kE9vFpLq9GWGaO0P/CNRk+/37VZzUH/MCsLEffPByMYaHLn2Q9CK7YYZVB/QsExy1IAawZGklpZcK8LAM89+4/CUEFPJp0rylDk1xLBz7FiF16IVeRQjbk/Gqz6Q/BZnLZj0p9w4o3tBiLxB0vhB2dZQER7jNmSF9FFQTtOMQhpv9LK3t6WUoA5Fcm5iz6SiBK2vW9n17wfsiYYOKHTOaa/MJ+bK4cv8Joz1w==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6245.prod.exchangelabs.com (2603:10b6:510:19::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Mon, 29 Mar 2021 13:49:47 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:49:47 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-rc 0/4] hfi fixes
Date:   Mon, 29 Mar 2021 09:48:16 -0400
Message-Id: <1617025700-31865-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [198.175.72.68]
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:a03:33e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Mon, 29 Mar 2021 13:49:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01db4988-9d20-4edf-81c8-08d8f2b983ba
X-MS-TrafficTypeDiagnostic: PH0PR01MB6245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB62455EE6AB995AAE854F535CF47E9@PH0PR01MB6245.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIF7pxq1mBxys/kqon04zgbfJV4O7teEVCIJuCMPn8j+Sh2WGWfpGTjzLz94dOuzvf6povpEae7pAHGBKCDTM4fvTnZRKsi4+Rb4uvc99NRxUCaTfSA1H6K9eyV271HJJEREv1hxzANPafMy0tS/VHgc05yPvsWEIClHBo1NluFASwd/a+TOoWbuQ4T62XLZmhVbbJa55MT5ZzTDJInQVlhxU2FKqnmdQpjL82L5sSnRIGBVXjs5WsrM1l1JhyJHrOaUt279wLuwcK6lH9q5qWx99I3xp6IKlQBrOQMyb8+69f4IJcEhIA54P+xGj1L70wYXRL3TJkdZlPjqHQiJ1ppd4Y0vnp7/Rp0K82i7Kah/o1xKIJ9KObRGFNsbS407o5jJKFygROgKRJytvTOoDwzAT4WrquB7Z6pQljm73Nm3O6IKB5W5krGpOfAlAHAk00VTMMjXVq7ft66KVMZYYTBVMUlK/HOaOkUUu7yN5J5jXnJk8x45Xtwb5Oyzd7eGUtIx7zoLO5UCn1f2PWSdVRITPsNzM4UUPI7djPDLo3xAHQdNM2wOfVURX/4m20Qb52Zb9bdYnqFubw2wzggsKWFxBg+SRWxhKS7u85Ne5hxwi87/BK/JK6W8dczTTu6rM39bHwsMS15JqF88o9PAVfJ58i76VuT94aLzrQQPw8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(376002)(346002)(366004)(396003)(8936002)(2616005)(107886003)(52116002)(7696005)(8676002)(6666004)(86362001)(956004)(38100700001)(4326008)(2906002)(186003)(478600001)(16526019)(6486002)(36756003)(316002)(9686003)(66556008)(5660300002)(66476007)(26005)(66946007)(83380400001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iQz+LiV4LP9f+xvJtqWGOnG/mnRTK+ZdqLEXp6zKZGrwft2uUjLQj3esRYOi?=
 =?us-ascii?Q?zCJNym1uxnGcig5lf4u0F57DFicBs69HhLXNkrcIG31qbr4t1w+mOS4vwP3h?=
 =?us-ascii?Q?rsLYaBVLNAhg81B2HTzfiwhUFrcr4F0oj6prZJQd3fRrWC7hXXFOtdHXtAyg?=
 =?us-ascii?Q?cx+/vsTPVR/HDHlPwRzHGP62YbCzBbGrlzic3LVPROVKdzOfWQTB4Vz1aS6S?=
 =?us-ascii?Q?VpNnfSYI0GqAC6istoh7vuP0Dl1ppj39YPSkn5rRwLgV/t0e9x4z64VHGAtX?=
 =?us-ascii?Q?XEXx2So5jih0ZXN4EicW5/wXd/TrtucRWA7/OdTrp1Xfyjaty+r9XlTQk6Pv?=
 =?us-ascii?Q?a8ntheD6I+gNX3zJasz+ILGgLoOIJHvfUdfuq4K+3NqJPws6NS1G1/DDaRG+?=
 =?us-ascii?Q?uf4UImCz2iiOaCU0lNv4CWO4cOhtXnBdP/DnFpn5Nn2KRfO+AKuVIWfrUla4?=
 =?us-ascii?Q?meAr9wFsKd5CtiqpJThbph42cD0JlHiPF62Sa96Ph7AZx/EAwpAIjSHdTkul?=
 =?us-ascii?Q?pVkpzLSea6nfj7KcRwO3ouQN2jBEWkHildNbKqK5PfgrWMY1WtPC+dZFFNZD?=
 =?us-ascii?Q?f6EUQHi0IQdR4einkXm6182jfwi/2m4UzgEId13jn441es1u7v4on1rIzYjZ?=
 =?us-ascii?Q?+b4SNBZF0vHTM6Coghmd9CSxbmBASl7sstzDcQkU06ZbVW9JwXqNYbohdqP7?=
 =?us-ascii?Q?8kJaiZaoeT7ZbFe3AM0GZsC1lN/W6fpjLh8o1v8XuiftganqSxRw1ujvf15C?=
 =?us-ascii?Q?fqkVesKrNpL9RhkGDSqSNRFy6x7DAttm9sBgaJMSCTBJ4HjdJOuerrlMuOXB?=
 =?us-ascii?Q?kiLEKt2lmZWnm+qC6geWFlS9pKSC3+zMN4Bw62IINF8Tix9/kG8qs1E4cCm6?=
 =?us-ascii?Q?C/wQDV9sDyzFMhwbs+pLINzSoz6xNJ3TNYJn3MN4DiPdyd5iKKy3mQXZSmSE?=
 =?us-ascii?Q?rLnWC/GctciqQMLxlMndSc5QuB/i7Nt1xR8aXeAbWWt390lVt0Ro9qcckIrm?=
 =?us-ascii?Q?h5R4EICNH/HVcQqU1APbm1XU8LShtOw7UPR+ZI2SMBiiK3omtZpGq0Ak0vg2?=
 =?us-ascii?Q?SfmyXZCzd16vg0F3javmaBwBqRrl3gxVvYsRjK9/rdFxrIvH3Ip1hhkPMEG+?=
 =?us-ascii?Q?t9jDjiUlOYThWAdSzX84CWRrVH4neriGgxjb+IoTQRHlJpRXs6FiRoP4lBSe?=
 =?us-ascii?Q?zCQUfgPqWdKN+XegSfXw2+2Bs1kCsfQCIKC8+6nJk6oi/PqzUvfcfr3laQtq?=
 =?us-ascii?Q?MHeJKrcfFaptuhsAFmTtWZVnc+qjZD3vzSoJhRbPtaHNIX+ERyuHWPjPbHwZ?=
 =?us-ascii?Q?uGzzrFBO3MOvw6r0HlQA7UEn?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01db4988-9d20-4edf-81c8-08d8f2b983ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:49:46.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1xR3a0g42mHEMOwApGXxLMtIOeWWTS1LM+cTV9J6Fvn9LPFKZqE8Ce6bptWFRJOhe9OVwDpCMHs0R6GKtpm0kF7NIDQb4NRcmt7d0HrIS+OYr7lhDv7HsyhiU3ejQUQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6245
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

Here are a couple patches that fix outstanding issues. Two patches from Kaike
address memory leak issues. The two from Mike fix a panic and a list corruption.

Kaike Wan (2):
  IB/hfi1: Call xa_destroy before freeing dummy_netdev
  IB/hfi1: Call xa_destroy before unloading the module

Mike Marciniszyn (2):
  IB/hfi1: Fix probe time panic when AIP is enabled with a buggy BIOS
  IB/hfi1: Fix regressions in security fix

 drivers/infiniband/hw/hfi1/affinity.c  | 21 +++++----------------
 drivers/infiniband/hw/hfi1/hfi.h       |  1 +
 drivers/infiniband/hw/hfi1/init.c      | 12 ++++++++++--
 drivers/infiniband/hw/hfi1/mmu_rb.c    |  9 ---------
 drivers/infiniband/hw/hfi1/netdev_rx.c |  7 +++++--
 5 files changed, 21 insertions(+), 29 deletions(-)

-- 
1.8.3.1

