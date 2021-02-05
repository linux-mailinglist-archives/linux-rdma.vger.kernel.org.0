Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968BA31066C
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 09:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhBEIPr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 03:15:47 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:27561 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230497AbhBEIPp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 03:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1612512875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=D7KGpNKP5c4YsVIWkNNT2LBp/McSIKC1f4Btkv09J6A=;
        b=Fa5a2PcglGdGhZlqAKxPj2nn7updx5ww6lKmkgDpIZE2uMIygrsJUcVN37oloHx99ZBCow
        uT3YYzRVBB+Pb0sez9Dyvs2F62l5VYrsr0SatvRfYeBwhns+Y3TL2SBcLQsVnKQHeIelc1
        FRbTe+oZJ2auh6h7KomfhqZWmq+tLz8=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-9-Dbb_ezUyNYe7xCMDss1F1A-1;
 Fri, 05 Feb 2021 09:14:32 +0100
X-MC-Unique: Dbb_ezUyNYe7xCMDss1F1A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfQc50fDjJtOhzzZ331wxtyhjLe2305tQNGSOnHYAy8oFjqHe/sCwazptbUN8LCVQYuoSx/q+Iq2rnjOV7U3H3zN/KrZp0232hwvFG9eb2JcPDq2b9VLUYCzuXd+8AuWMgC26/vsgXC6lrHM9cqpBYa3nkEQU7hJQPny23MYkX+RGK2F8EBokOmPhMLWMqknB5eQPa3kGx10Mb/AO4zQLu/9fuIrX5DGyQjMLhOeUvSi+UlBSyv2FOocMdgl/kQXSp3BaTWv/ZJ2issjGq4BfrZez9r/k6QaC8z/04m4JVcxTklpSMQLjlTrATuqNvNW90jglN65L2q+inKtyYSZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7KGpNKP5c4YsVIWkNNT2LBp/McSIKC1f4Btkv09J6A=;
 b=VLpsZPBdxRkAuaPypE9iBBncZWR9miPmyOni0Kr6Aqvc4w8CauSI5kyLG0fJP+VPPlzu8rSCYr6PqrX3I6uJzCZAwAvwbIu/C2ICs3IWj5ZDAQVY3y4RHfDqbDbCXcmY2oOUVyeWg7fLXm+ODsoz5N6mxmwavnF3tm5EbbuZR5NeJkPVVg6pq4A4x/P1uoDPHnHCnaGWSYI78TXiJo4a0R9iXT1yJv2kefBacrsp3OZFQH6WUmkQTthcY5kNr2Ctsu8tI0ipSoMAxJE8gp9aoeY4e/JCQn9+1YhOunCvblYHl6xrDvCKOR2j5QuEqCYpwdk2mw2SVNRCqWRIVHQDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB6PR04MB3272.eurprd04.prod.outlook.com (2603:10a6:6:10::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.27; Fri, 5 Feb
 2021 08:14:29 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::bddb:c1fe:f800:8f1b]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::bddb:c1fe:f800:8f1b%7]) with mapi id 15.20.3825.021; Fri, 5 Feb 2021
 08:14:29 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH] RDMA/srp: Fix support for unpopulated and unbalanced NUMA
 nodes
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        bart.vanassche@wdc.com
Message-ID: <9cb4d9d3-30ad-2276-7eff-e85f7ddfb411@suse.com>
Date:   Fri, 5 Feb 2021 09:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.220.112.205]
X-ClientProxiedBy: PR0P264CA0100.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::16) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.220.112.205) by PR0P264CA0100.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19 via Frontend Transport; Fri, 5 Feb 2021 08:14:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5af2dd87-e3a4-467a-b640-08d8c9ae0fab
X-MS-TrafficTypeDiagnostic: DB6PR04MB3272:
X-Microsoft-Antispam-PRVS: <DB6PR04MB32726779DA8C1EC81B937A41BFB29@DB6PR04MB3272.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sShLyZ3t4HFgF3CLdWR6bZIe0yv9MtHT/Y70jr2urjLr+i8JjDel0Jqjrm2s5hrYdKP7O6viuIrOHJMFYuudM/dkDb1YUbGePSNiudp6ae70vp5XoZtogPzQSO5oFaY0Qk0kFpubUHxB3K4VoRmSCxwfHAiLzFZS0ffV7ZxY3mTl1E35n+Bvwa1GhA+krXET646NlDgQW/ZEnQ1JFqKYvDQxMy4/Xe3QI2TKmgUW/dg6T99Mj0cx4yb4OkV4EHhHsoVAn9pFwa/8jYrTIKcvuDq+GjVO6lI+Yyxu8IsfaSB/ndaD2spl9Clun+9II1oQhrVLSaAoY+3Im1Qr29Wp65w6ygLeHY8BDlTpgG7ogBz8FrNQrtEKxiFx9ug2LC2RrJvXsi4rBZAkmSasJBHxpNdHAMKULmh6ngkotKEwXUCNF3foryDscgeW/gFh5xzZrlb+FITLoyTvRzKGFIwIRxLlVHYquzQRaWwUJPytaOyuXhz92nPRNRwb5UI8CFtEJz+/fiumwnvTYU9VgxWnl5ieutSsopRN0XYjbfABazxFh6Os43Dq2I0bH3l3F96j59XLcPLq0nvMfRKUlPSGEP+255b/2AQ8WkYeiS7LchI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(8676002)(16526019)(5660300002)(2616005)(26005)(186003)(478600001)(66946007)(31696002)(2906002)(316002)(66476007)(36756003)(8936002)(66556008)(83380400001)(52116002)(6486002)(86362001)(31686004)(16576012)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?UPqYbR4n2fl3wJdbY6lN34noRrXE68oiR9HVDr66IB659XQvscyp4l8t?=
 =?Windows-1252?Q?0TLTbof2MNJ2uQ7rUje+VS+dxeSOVD+3CWlQuxc4RJJjRHcr8uTp1p3t?=
 =?Windows-1252?Q?S0NPsLVhLP+cu0oYcdpSAfjQcBQn4/qxdVOa95sRqfci3BrM7PpGXqxd?=
 =?Windows-1252?Q?sl/2VsRAQ1x+oWaF/vB4myRyO7+Fdc9+M3S0VvA8El+qOTWPSzzvGSPr?=
 =?Windows-1252?Q?wkD+NjBe973RKQySCKw5nOxjmSEyLMDs+6GiBinP65NpQ4KnWPE4K+cK?=
 =?Windows-1252?Q?wLV0lGT99OUX4zAxVPMWfs+daGAsxkh/oTRwenadn8ReTumAXclhfA1G?=
 =?Windows-1252?Q?9DnVB9w4u5HXfWtW7X8wgmyaKI6Py9dK9CN6Pnzend29uE1ChMOE0Y3G?=
 =?Windows-1252?Q?A2jDqHmoq2+bfw8YDuGBhrjKh1B/ds88LOxwUGaNZmSeq49PBB1puqKx?=
 =?Windows-1252?Q?JQgujCGHks+FJEoo3+vvzKHJDuooUQiV0nWyTKmUWZW8O1gBfSUZ4JZX?=
 =?Windows-1252?Q?D0R7oteX4paUeUk1NiOm8YE2qOcmLtYX7d1MMKdTe9CxeVs1yeHuDqYX?=
 =?Windows-1252?Q?n7KaS15yDMazca+TnJUw+167Ap9ow6sZaoXNOkvWQWpWJohaJSpR0ocI?=
 =?Windows-1252?Q?4ZefxEIbEFAyYeaAFWZpzI8AXNZDOxR0cZgtjW5hRAN9oHYWYv9cHEgb?=
 =?Windows-1252?Q?zr2/n8IUKm6Af4ZDceHeILXAUOb2wWxVsYUIvkxctZpx6tpUj5IXM1x7?=
 =?Windows-1252?Q?2k57zRETAVP/PK5IgAKhy+2kfk1dW9IE3kXyrWlMae47dJtAyJV07+9e?=
 =?Windows-1252?Q?ys0M8LH/TDc4Dk4vXrgtE2GjpSl8Z95h4riqk1uOVu+zksq9aZR3W2lY?=
 =?Windows-1252?Q?JNxAi46Aqy52iTkmwfXoKAxAEtmVmMcY98ZkuPIXSHGgyV6931KtaY5h?=
 =?Windows-1252?Q?weT4Ls3Q/BTsLPOTeSvfJI4XL8AxQxEq6l2ZBWiYuM9n8zgg19kbLza4?=
 =?Windows-1252?Q?qN4ZA0AqbV1sVXlD9QaNMAEqjiE4BkrXGFomoEoTqlJ3gN1jEj8Erz46?=
 =?Windows-1252?Q?bChVc09Vo3Iv8EWYJhOYvIDDpmypzSz1uQiYrPgSgknJyIkBanqyD/kV?=
 =?Windows-1252?Q?2BMHB+iuQsCAOIv5Cnx1OpxcQ3FhwM7pTMqZkJl8v159T3ntjSmaG8j0?=
 =?Windows-1252?Q?J+eBXFWNQrG8hqGcfQWTNUh91vmO81II2p4qkENu9xfSI5IJpkfFRjJU?=
 =?Windows-1252?Q?OUS5PNCaR7FbF5uwB/gNTlRi2INnv5bO03E22+OokYGHKRR9fDP6An58?=
 =?Windows-1252?Q?R99UE7/jq+0UPLt96xhmIXk1WU3Q5XxeqVOk603Jr8x7erXlLihezypr?=
 =?Windows-1252?Q?bAfKv8rJCj/q1EKgXpRLOM2E1mXFFG33wT2GKOdoMRjF5Y43Wk4xZzl3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af2dd87-e3a4-467a-b640-08d8c9ae0fab
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 08:14:29.8294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Dt33N9PkKkJSKobUcz+ptWwgskpSiemjGCWa8j7/gmEVpSrQLLGUS8IF+s60njVgT3I0CR6Wf+FEC3jnwpgLdcyrY79hIuRlNVndNOwokc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The current code computes a number of channels per SRP target and spreads
them equally across all online NUMA nodes.
Each channel is then assigned a CPU within this node.

In the case of unbalanced, or even unpopulated nodes, some channels
do not get a CPU associated and thus do not get connected.
This causes the SRP connection to fail.

This patch solves the issue by rewriting channel computation and allocation:
- Drop channel to node/CPU association as it had
  no real effect on locality but added unnecessary complexity.
- Tweak the number of channels allocated to reduce CPU contention when possible:
  - Up to one channel per CPU (instead of up to 4 by node)
  - At least 4 channels per node, unless ch_count module parameter is used.

Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 110 ++++++++++++----------------
 1 file changed, 45 insertions(+), 65 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 5492b66a8153..31f8aa2c40ed 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3628,7 +3628,7 @@ static ssize_t srp_create_target(struct device *dev,
 	struct srp_rdma_ch *ch;
 	struct srp_device *srp_dev = host->srp_dev;
 	struct ib_device *ibdev = srp_dev->dev;
-	int ret, node_idx, node, cpu, i;
+	int ret, i, ch_idx;
 	unsigned int max_sectors_per_mr, mr_per_cmd = 0;
 	bool multich = false;
 	uint32_t max_iu_len;
@@ -3753,81 +3753,61 @@ static ssize_t srp_create_target(struct device *dev,
 		goto out;
 
 	ret = -ENOMEM;
-	if (target->ch_count == 0)
+	if (target->ch_count == 0) {
 		target->ch_count =
-			max_t(unsigned int, num_online_nodes(),
-			      min(ch_count ?:
-					  min(4 * num_online_nodes(),
-					      ibdev->num_comp_vectors),
-				  num_online_cpus()));
+			min(ch_count ?:
+				max(4 * num_online_nodes(),
+				    ibdev->num_comp_vectors),
+				num_online_cpus());
+	}
+
 	target->ch = kcalloc(target->ch_count, sizeof(*target->ch),
 			     GFP_KERNEL);
 	if (!target->ch)
 		goto out;
 
-	node_idx = 0;
-	for_each_online_node(node) {
-		const int ch_start = (node_idx * target->ch_count /
-				      num_online_nodes());
-		const int ch_end = ((node_idx + 1) * target->ch_count /
-				    num_online_nodes());
-		const int cv_start = node_idx * ibdev->num_comp_vectors /
-				     num_online_nodes();
-		const int cv_end = (node_idx + 1) * ibdev->num_comp_vectors /
-				   num_online_nodes();
-		int cpu_idx = 0;
-
-		for_each_online_cpu(cpu) {
-			if (cpu_to_node(cpu) != node)
-				continue;
-			if (ch_start + cpu_idx >= ch_end)
-				continue;
-			ch = &target->ch[ch_start + cpu_idx];
-			ch->target = target;
-			ch->comp_vector = cv_start == cv_end ? cv_start :
-				cv_start + cpu_idx % (cv_end - cv_start);
-			spin_lock_init(&ch->lock);
-			INIT_LIST_HEAD(&ch->free_tx);
-			ret = srp_new_cm_id(ch);
-			if (ret)
-				goto err_disconnect;
+	for (ch_idx = 0; ch_idx < target->ch_count; ++ch_idx) {
+		ch = &target->ch[ch_idx];
+		ch->target = target;
+		ch->comp_vector = ch_idx % ibdev->num_comp_vectors;
+		spin_lock_init(&ch->lock);
+		INIT_LIST_HEAD(&ch->free_tx);
+		ret = srp_new_cm_id(ch);
+		if (ret)
+			goto err_disconnect;
 
-			ret = srp_create_ch_ib(ch);
-			if (ret)
-				goto err_disconnect;
+		ret = srp_create_ch_ib(ch);
+		if (ret)
+			goto err_disconnect;
 
-			ret = srp_alloc_req_data(ch);
-			if (ret)
-				goto err_disconnect;
+		ret = srp_alloc_req_data(ch);
+		if (ret)
+			goto err_disconnect;
 
-			ret = srp_connect_ch(ch, max_iu_len, multich);
-			if (ret) {
-				char dst[64];
-
-				if (target->using_rdma_cm)
-					snprintf(dst, sizeof(dst), "%pIS",
-						 &target->rdma_cm.dst);
-				else
-					snprintf(dst, sizeof(dst), "%pI6",
-						 target->ib_cm.orig_dgid.raw);
-				shost_printk(KERN_ERR, target->scsi_host,
-					     PFX "Connection %d/%d to %s failed\n",
-					     ch_start + cpu_idx,
-					     target->ch_count, dst);
-				if (node_idx == 0 && cpu_idx == 0) {
-					goto free_ch;
-				} else {
-					srp_free_ch_ib(target, ch);
-					srp_free_req_data(target, ch);
-					target->ch_count = ch - target->ch;
-					goto connected;
-				}
-			}
+		ret = srp_connect_ch(ch, max_iu_len, multich);
+		if (ret) {
+			char dst[64];
 
-			multich = true;
-			cpu_idx++;
+			if (target->using_rdma_cm)
+				snprintf(dst, sizeof(dst), "%pIS",
+					&target->rdma_cm.dst);
+			else
+				snprintf(dst, sizeof(dst), "%pI6",
+					target->ib_cm.orig_dgid.raw);
+			shost_printk(KERN_ERR, target->scsi_host,
+				PFX "Connection %d/%d to %s failed\n",
+				ch_idx,
+				target->ch_count, dst);
+			if (ch_idx == 0) {
+				goto free_ch;
+			} else {
+				srp_free_ch_ib(target, ch);
+				srp_free_req_data(target, ch);
+				target->ch_count = ch - target->ch;
+				goto connected;
+			}
 		}
-		node_idx++;
+		multich = true;
 	}
 
 connected:
-- 
2.30.0.4.g42936b2fde60

