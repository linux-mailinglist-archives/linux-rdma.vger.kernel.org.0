Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44F2C4795
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 19:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbgKYS0k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 13:26:40 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:47976 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732581AbgKYS0k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Nov 2020 13:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1606328796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IcI9IoYkBxUh8Q5R7EtTknIMK4WNhR6NVIelDWopizU=;
        b=GL+V3CNdap5isGksEdiP2fntB1DfGRfsGQvM2Lfi4VH2JmijeTLy5fPdphZcAaE/Dl9ycG
        caBum0S6shTXha7oQdxqrZ8Jk0zRRaxylRHkbo/PwHMyUHGLMlOIWfNc2fQCAt34jUjKLu
        lIa1o9/IwN1BXetWbjt2U/Hv2+wjqRw=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-6-aVEc9vKjNQGLE6lEcbFXaQ-1;
 Wed, 25 Nov 2020 19:26:34 +0100
X-MC-Unique: aVEc9vKjNQGLE6lEcbFXaQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqXntzbOFQlHDTdCWB0Kdt2K/0Bha8yW5cA9d6kJQxi4cxcURRaNwKokPoYh4K4h8idaZLF/iN94gM4hPeFq9Ax3zJTS0lWYMWR5mKF7NiQJPFCwEmZ/teNs371Hwal1d3PQOtL+wjSg6v3oO0GxPVSQDuZzLm/+HeZWMmp6OOkoei/ltcJob6N10oMhyBiP/AzC6dx9+fw1vbXyGQdccq/Ejx2we+ZdLyOZxVPoWe6Aat0JYhC8Eq3b3anGnIVj091n1bq8JVCdtcIn7RWEE6i3WT+ZGXHff2YcnVQJIQPFkcKNO4QYLd2pPdrPVHwmRYwZiV8vRTyqX53EgeNmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcI9IoYkBxUh8Q5R7EtTknIMK4WNhR6NVIelDWopizU=;
 b=A65z+L3QqvXkOwv/vldCO2NqfuAKcVKi4Xhk1N0p8pU0mfo9jxEXboIrg0ftxEYe4tzMFHj190EtARl8E/GQbUYD98/qs1TqAJ850CuuLpuW4DnZDDFe3WIY25FJ9ShP/dQL88Xxc+3C/3JagL15D7pRIqrNYs79gmm+9B2Se+5bydIgENF9XgKOpEFmoM9j3twrsiHemMAPANn18lYTNBEn/kGdnhdcBJMukAWCJ52j8SLnKRM/1kM0YvI3TApNLQ0tbSQG/lBA7Cc0TKEs1Kyfvo6cOQFkf0hHDNu3Yzv9nTE2fT8JqTsSwr6rCPsEhc36nCYJu12IgTVp7Ti2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DBBPR04MB7660.eurprd04.prod.outlook.com (2603:10a6:10:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Wed, 25 Nov
 2020 18:26:33 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41%7]) with mapi id 15.20.3611.020; Wed, 25 Nov 2020
 18:26:33 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH] RDMA/srp: Fix support for unpopulated NUMA nodes
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <6c9f38f6-de5b-d01f-f67a-52a518d2a26d@suse.com>
Date:   Wed, 25 Nov 2020 19:26:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.199.24]
X-ClientProxiedBy: PR0P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::22) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.200.199.24) by PR0P264CA0106.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 18:26:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 973f6425-f9f5-4d97-581c-08d8916fa29e
X-MS-TrafficTypeDiagnostic: DBBPR04MB7660:
X-Microsoft-Antispam-PRVS: <DBBPR04MB7660B30DC16B0CF30070DA0EBFFA0@DBBPR04MB7660.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTLRGRBFm4uww4mSeje/lQrbnfp2X/NM9Uj9oBLkMNS2sbx5QaiXYPMyrLHqEioMXk71Bq+tYJljE0zXb/UW7ADE+EEMfcgm1HRuB3Ob4u0TuuOoSU5e+UkNvfTs3CPEozaRjoynHCuIlTq+dmsGk+iWrtf5WocqzrHm5SRonuurvJERf2le4IbB91NIFA4Z0+Fb+vAbJvUthFuS9GQKcRHTWbrbrs4sh8SIh7kK7UJO7GrnlxJ1mA12BMNGljZd5VSaMWlcsslo+fBaOK6+JAl/pfPA64TxoJxYCqWLmHKf9BuWhL0XNhlWcQsFR0O64RD5WyEfoNutUxUVzvTrAiCyZH/1DxfjU8bmGzoeIo+5aq6YeLoFeFc1jZhfcUzV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(346002)(136003)(66476007)(66946007)(66556008)(26005)(31686004)(110136005)(186003)(6486002)(86362001)(36756003)(16526019)(2616005)(956004)(478600001)(2906002)(52116002)(83380400001)(316002)(31696002)(5660300002)(8676002)(6666004)(16576012)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?aVWl2qY2zgSjDZi6aMhuWw5cAE3E3zEJREDV4V+nGSNhKVbhdzOSOfto?=
 =?Windows-1252?Q?V17Zg0tXiJOXrCTCLpFOUHFyP4qT4Fg8jufURwFOlzN17PlmUWPULUEk?=
 =?Windows-1252?Q?3Ye/VuXhHygNKnu8YVfEfuyTC8/VLs15QEgTPhEDmmrW9woNQ40ofZTG?=
 =?Windows-1252?Q?n+tjZwm6rmhU3J7r2X7VreOR7wZ9HWMHfx4dBEn1I5trhmmcTNPbtfmQ?=
 =?Windows-1252?Q?dfgHc3scZu/qAMKiHt61abvT9nIbEWs8hZHK7jt/bNnCeBKoOXW+kHLQ?=
 =?Windows-1252?Q?b81BICkcJJ2ZilGxo1OdQCi2ePZVhNDXeidbMc9YVQKKUPtaNYARD9d5?=
 =?Windows-1252?Q?Notoqy44WJCe7R5v0n4szXsexslJnyBDlV5xqyUAaRLZe892N+c1diLa?=
 =?Windows-1252?Q?MiDJEzeV2hddxRM1HekJ0jE1xhDzPjmFH4FzB4Hu1I55890qqz5znVMP?=
 =?Windows-1252?Q?DEPl/1HvlZyXet/VfirQ0/w0kfFGoHMu4JWCo80vyn+DcAQWMqJeFC/X?=
 =?Windows-1252?Q?u2BLMzJm/T/rlmONTs83+z71xnAwIXB8o4RhpqE5Kh567R2FdokIlrKI?=
 =?Windows-1252?Q?ZhLirIVeccE5M+gvEPdF2+w6fmQzTNUaUwKIlnhBYZ9o1eDxh0SsOJ9M?=
 =?Windows-1252?Q?t1izTg/5Y6DUeX6O3YfQFZL+9yXbvWifP3sx02aQm6RX7AHKkEQlq1Cn?=
 =?Windows-1252?Q?SAsDVfNHpRnAropipbZIwkixfKh7me7mefxUI2GCN79GImPYDBN6/BLF?=
 =?Windows-1252?Q?r5JGJz75YO571SyUaxaRoHm6795pP0qvQkucHFGHSvIZW167TdPyKMB9?=
 =?Windows-1252?Q?Npug8TVDfnGf9sPAkhXPu2PYfapNFiheBix832yqANpwksbRc2vBUFFZ?=
 =?Windows-1252?Q?u3X1T/tMjWfdMcHCQx80Qfy8qBsaiiPtKZJizs6tfKBwB/5T1h7+yqCA?=
 =?Windows-1252?Q?qm2z4tsTqaJxdim95t+R8mV9AQrwgwXWnp4bl4NgdcAnM/mat8TRZjHG?=
 =?Windows-1252?Q?In96vZ+xzm1tQCGAmL20jJAYivtcHMrRDNn4fOXjP33y4IzExn20O74S?=
 =?Windows-1252?Q?oaHABIrfeb2tgz/V?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973f6425-f9f5-4d97-581c-08d8916fa29e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 18:26:33.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +u6FRNDlzTbrJWN1rKKU6y87/3XKQ0qOROsEaUqB4zm0gwTb0tZNDJeq9fkANZS6axOpwotPRwV5GwwGPpS26xboHd2UTF0XIdFouKv84Tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7660
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The current code computes a number of channels per SRP target and spread them
equally across all online NUMA nodes.
Each channel is then assigned a CPU within this node.

However some NUMA nodes may not have any online CPU at the time.
This causes the SRP connection to fail as some channels do not get connected.

This patch solves the issue by using the number of populated NUMA nodes
instead of the number of online ones. It also ensures that there cannot be
more channels than online CPUs.

Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
---
  drivers/infiniband/ulp/srp/ib_srp.c | 48 ++++++++++++++++++++++-------
  1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index d8fcd21ab472..e0c4e1ac05d2 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3613,6 +3613,28 @@ static int srp_parse_options(struct net *net, const char *buf,
  	return ret;
  }
  
+static int srp_get_num_populated_nodes(void)
+{
+	int num_populated_nodes = 0;
+	int node, cpu;
+
+	for_each_online_node(node) {
+		bool populated = false;
+		for_each_online_cpu(cpu) {
+			if (cpu_to_node(cpu) == node){
+				populated = true;
+				break;
+			}
+		}
+		if (populated) {
+			num_populated_nodes++;
+			break;
+		}
+	}
+
+	return num_populated_nodes;
+}
+
  static ssize_t srp_create_target(struct device *dev,
  				 struct device_attribute *attr,
  				 const char *buf, size_t count)
@@ -3624,7 +3646,7 @@ static ssize_t srp_create_target(struct device *dev,
  	struct srp_rdma_ch *ch;
  	struct srp_device *srp_dev = host->srp_dev;
  	struct ib_device *ibdev = srp_dev->dev;
-	int ret, node_idx, node, cpu, i;
+	int ret, node_idx, node, cpu, i, num_populated_nodes;
  	unsigned int max_sectors_per_mr, mr_per_cmd = 0;
  	bool multich = false;
  	uint32_t max_iu_len;
@@ -3749,13 +3771,16 @@ static ssize_t srp_create_target(struct device *dev,
  		goto out;
  
  	ret = -ENOMEM;
+
+	num_populated_nodes = srp_get_num_populated_nodes();
+
  	if (target->ch_count == 0)
  		target->ch_count =
-			max_t(unsigned int, num_online_nodes(),
-			      min(ch_count ?:
-					  min(4 * num_online_nodes(),
-					      ibdev->num_comp_vectors),
-				  num_online_cpus()));
+			min(ch_count ?:
+				min(4 * num_populated_nodes,
+					ibdev->num_comp_vectors),
+				num_online_cpus());
+
  	target->ch = kcalloc(target->ch_count, sizeof(*target->ch),
  			     GFP_KERNEL);
  	if (!target->ch)
@@ -3764,13 +3789,13 @@ static ssize_t srp_create_target(struct device *dev,
  	node_idx = 0;
  	for_each_online_node(node) {
  		const int ch_start = (node_idx * target->ch_count /
-				      num_online_nodes());
+				      num_populated_nodes);
  		const int ch_end = ((node_idx + 1) * target->ch_count /
-				    num_online_nodes());
+				    num_populated_nodes);
  		const int cv_start = node_idx * ibdev->num_comp_vectors /
-				     num_online_nodes();
+				     num_populated_nodes;
  		const int cv_end = (node_idx + 1) * ibdev->num_comp_vectors /
-				   num_online_nodes();
+				   num_populated_nodes;
  		int cpu_idx = 0;
  
  		for_each_online_cpu(cpu) {
@@ -3823,7 +3848,8 @@ static ssize_t srp_create_target(struct device *dev,
  			multich = true;
  			cpu_idx++;
  		}
-		node_idx++;
+		if(cpu_idx)
+			node_idx++;
  	}
  
  connected:
-- 
2.29.2

