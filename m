Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CCC3CF608
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhGTHiD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:38:03 -0400
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:7904
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233099AbhGTHhw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/GaTReLeCDzxVqvuQLb9HPLapcrcm5gjRtpt3umGA7HLnE89soqd3RAcv+4k2Phq2SUKjZYO28lpQoRTAdE1s0J/aM8nkyarEba+4Mo8Zklz3m6kWyWUi341rbj2doCxAwyJfC0klNbtSq9aNHDYulZUhhlXEgPPUb0zfjgu4hajfRARPTkYUdz9joemMVMjGmOBsk/TsnNEED03451GbMzEdwKALWWi+PPysZGKwStyVBMINObnNtFVYKpzHZhAFpT20MCVGURPNe4dsmXNT8xdPAyY9cZ7j7p95qD4kaCW3LNm0ED+iGBNf1Q6+x0zQkCSnVe7MviSH33h+FDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbF9uOlIUamdP7ixBrEZM4+7/0FpJ826A5wQX6uoKUk=;
 b=ndNKI1Xv/LKAndE8Ns6/Z/eEGlCAnPS4TbaOI8a6uRsQ7jZ7ENuyckEQrVmZ9oX4FhvXvvc/jixTfyfpWz2LlCvIn8sXkXmlBDK3NIgCxF5xgkjnfobDorQmmgFwBaZL/8ldi/CunNTvb6en/cnWtK0C9LyxJjoZJBpuFVKiTwjnTmwBRM5Yw00YJ0Jlq0pSa45sp+iHwlPD/wCf/41UlXWV4uNBRjazqaDBXIes4f1EzCvHw4TYMN9ppkVDUNzaOS+zJt3JG9iyKxceAE9agZmoZ6nsFxTX7Twxr9pVXA/fk54gG1XO+G0KT278TZTEMWO5ikCNeUX6+6Sq+AqIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbF9uOlIUamdP7ixBrEZM4+7/0FpJ826A5wQX6uoKUk=;
 b=uC3zoOfHFam4/ElgFj5rxHlGvkdEQ4/47+lplZ4+IaGcykirqYYfsfqFkKILmkC9nxakcA8OObXCzPcnwFXptikmeSwqFK/NG8inPOaD3OCb9+XVQXAxrparOJ5amsCNdf6GLsZLiYEHHZ9fBwXpSPKGS8o6kn9VTf9kLuNyV8+IPXX1NGy2HBvix1sqxBaO28LAZ/ULMscs/jJ3qLZgvd5GDriuZttHQXHDLLJXC1BY+2b34gaC7cBBAm/tdjI4HUz0oiMKTo01AUEQjzDct9WxKOMjccR5apVDjXHBsFvQ64EHUNfZMAfpPSu80P9UrcMaptukdCCD41KQdDfrfg==
Received: from BN6PR22CA0071.namprd22.prod.outlook.com (2603:10b6:404:ca::33)
 by MN2PR12MB2911.namprd12.prod.outlook.com (2603:10b6:208:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 08:18:29 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::7b) by BN6PR22CA0071.outlook.office365.com
 (2603:10b6:404:ca::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:29 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 01:18:28 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:25 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        Ido Kalir <idok@nvidia.com>
Subject: [PATCH rdma-core 24/27] tests: Add MAC address to the tests' args
Date:   Tue, 20 Jul 2021 11:16:44 +0300
Message-ID: <20210720081647.1980-25-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0f89b99-3e2d-41e8-d92a-08d94b56f4a5
X-MS-TrafficTypeDiagnostic: MN2PR12MB2911:
X-Microsoft-Antispam-PRVS: <MN2PR12MB291180B897C3FB9C96B0C0DCC3E29@MN2PR12MB2911.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c46jfcNCwUdP8h3iirdRrytvSVyTGwL7S09IQn/Ih/NM9Kmq0JiULkOaCoNWdUae5WPzTrDNuObDam09BDH2YUjR05cEdZBpbZwYufwGDXsyji/qxUCj03dfhxVpqAPGWJAeJ0ZoPhaJs3bj6GTBr1arvA6ifq+EbHQ2zc9FpuTwW07EHit08Dz6aJDPHUw+xof1l2pM3aesVMq8qCM2H6MFqjYAJCZpGhg3PCeG6mQURgJjG273P2Rijg18lRsKCQo4vFiDis0M2WvBOzeAEfq5ev0uP6g8eTWpdPRTzkTJCglSm3VzTuE1wg7EuJH/dFiS5lvNkf9aBPia70H96Et5vp9nnlelmD4UIRw1x3BFXi0YzOU2M6zqNdN0OtsMK9CUIZjmv/q1x7sdxGoSzvwaopf4f9oSwNO2b+MugjcR2TMxvX3dNSka1IQTHGFAoPF/cXpxXcM2TR0acIZ9wvHcq92qHkiPVV6NzGsowxUkLW5oJm6UbWogoJX+5dDwhVHc9w8xhZEXjXEKQiqIU1OqVeDdj4uMmfNQl6Gdsde6njZB3L+ZhXy2g1+okvKaPO62690U8Z9wIPYk3fA8NfH3k8bVpSPL+TBgdXAQdLLQahmAEWEmmTQzBwly1M8yX8W/kb43VNDQZdWdlZWvRr3VMZMUwNV7lABdSsndH55JLtseNd5k5Ir3x45sRKWsJjrd12IiFbDdZwkeMaAYPQ==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(186003)(6666004)(336012)(7696005)(8676002)(54906003)(82310400003)(36860700001)(8936002)(1076003)(47076005)(86362001)(26005)(5660300002)(426003)(2616005)(316002)(36756003)(70586007)(70206006)(107886003)(6916009)(508600001)(4326008)(83380400001)(7636003)(356005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:29.1767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f89b99-3e2d-41e8-d92a-08d94b56f4a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2911
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Edward Srouji <edwards@nvidia.com>

Append the MAC address of the relevant interface to the tests'
arguments.

Reviewed-by: Ido Kalir <idok@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 tests/base.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/base.py b/tests/base.py
index dcebdc7..f5518d1 100644
--- a/tests/base.py
+++ b/tests/base.py
@@ -131,6 +131,7 @@ class RDMATestCase(unittest.TestCase):
         self.pkey_index = pkey_index
         self.gid_type = gid_type if gid_index is None else None
         self.ip_addr = None
+        self.mac_addr = None
         self.pre_environment = {}
         self.server = None
         self.client = None
@@ -168,13 +169,14 @@ class RDMATestCase(unittest.TestCase):
         return out.decode().split('\n')[0]
 
     @staticmethod
-    def get_ip_address(ifname):
+    def get_ip_mac_address(ifname):
         out = subprocess.check_output(['ip', '-j', 'addr', 'show', ifname])
         loaded_json = json.loads(out.decode())
         interface = loaded_json[0]['addr_info'][0]['local']
+        mac = loaded_json[0]['address']
         if 'fe80::' in interface:
             interface = interface + '%' + ifname
-        return interface
+        return interface, mac
 
     def setUp(self):
         """
@@ -242,11 +244,11 @@ class RDMATestCase(unittest.TestCase):
                 continue
             net_name = self.get_net_name(dev)
             try:
-                ip_addr = self.get_ip_address(net_name)
+                ip_addr, mac_addr = self.get_ip_mac_address(net_name)
             except (KeyError, IndexError):
-                self.args.append([dev, port, idx, None])
+                self.args.append([dev, port, idx, None, None])
             else:
-                self.args.append([dev, port, idx, ip_addr])
+                self.args.append([dev, port, idx, ip_addr, mac_addr])
 
     def _add_gids_per_device(self, ctx, dev):
         self._add_gids_per_port(ctx, dev, self.ib_port)
@@ -264,6 +266,7 @@ class RDMATestCase(unittest.TestCase):
         self.ib_port = args[1]
         self.gid_index = args[2]
         self.ip_addr = args[3]
+        self.mac_addr = args[4]
 
     def set_env_variable(self, var, value):
         """
-- 
1.8.3.1

