Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE334D1ED
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 15:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhC2NzK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 09:55:10 -0400
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:33857
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231945AbhC2NzF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 09:55:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEuT79sV2YuTXcOWhPQj+8SmrRUXY1ZW7anbLVRrJjyH4UlzAYexlcFIb49YrsXt//4wYP4Zpc6Ia6u/maUKaglULfOp/o9FFQVK0Sep2fhYuvlKmgJvJLl2O7lalmRChJEak+pNhxZ5JJ+j6G+NuWPy5Nm0tF1p7v2i26FDNqXAyNBCPCNKWhhAqnJbzBBB1+HaOw94IhJxTFDfZX7vZP5CloArkzjq9HWLW+eBFM0J9rG2Sqsza8hri/sYipeeXM245nB+Y7EOnkuJdjd6xZbRMxTyVH2x20E/VJOLxK610wGYGmtcdGcoCCxP+HBfDDa4jaCC9uaGjvjdOrCoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JlNF6t90J4PR1SEJEUMxo8pseMhKRxDAHB378WosgA=;
 b=kHQSGv+8/mnW/8zlHF1s4nuQcReFN8t77s4UO2ZT1oN4R+VVOyBWk+LoUusEEN189qVXQsjrg+5zoxhJLIPES1O6HhN/xvbXP3zu6WF/sI5cK03CusdoCk2Srq59CKao9+PbtMwqgYftkyOLOZp9iDp+3EmPXJGrbEYITas4jbmWZ9ZFuE00SrdqScrrrasuwyMLwBlP8d6SN1eyzqaWhxnTMGgxI1nn6aX0gZAN1h8A05V//2lEZJrHJSW8psVnyLQoYry5gxqmt9al0wyuLmNm5JUq2dBhbxmYqVrsLe7mxdnO/MgLA8vYuOnI6D79bKHLEpFkUYbVLtiWsGgMcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JlNF6t90J4PR1SEJEUMxo8pseMhKRxDAHB378WosgA=;
 b=bqFXfRovweE3NnMBRG1kK3DfvpDOk9vk9liC6dR0mT/l85DG9i27DwPkZKWQUnVIR7yHP7Z0hrDum/vQjJSQe5SebJQNcpMi7AhJHQnpbjXKuYkAHuX+HNDb7bZ2xhlv0QeXeLR3qAqtFAlMGIapawi9TAE8osHaTOpGlDjMQSk9Q1j4VRALBZDjGIKRLNPW7uZmLx7CRzmxqUKlN4kGdsZ0T+/duIL0MkGSr78wlk6OLPGeoaFcXqoEoFwsEDa2CpxbRwrKiicqvYMlu7P6LvmIusHuPkWhD6P2wnzGFcxcA0nCDZrr1FcXWVUs0esY0UH8ENbE6wz5+bSCx9/aNw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6618.prod.exchangelabs.com (2603:10b6:510:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24; Mon, 29 Mar 2021 13:55:03 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 13:55:03 +0000
From:   dennis.dalessandro@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH for-next 04/10] IB/hfi1: Use napi_schedule_irqoff() for tx napi
Date:   Mon, 29 Mar 2021 09:54:10 -0400
Message-Id: <1617026056-50483-5-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain
X-Originating-IP: [198.175.72.68]
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (198.175.72.68) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Mon, 29 Mar 2021 13:55:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8231ba64-346b-415d-de1b-08d8f2ba409e
X-MS-TrafficTypeDiagnostic: PH0PR01MB6618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB661824B147422C3535CD4907F47E9@PH0PR01MB6618.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ealvH7Sv+jPZmLkq3lSh2l3V29zh50hSKnKcKtm/uY/iOyj4BI3Q9T78pDpK/zXLjNkk/peZSYMPpA8gqpNr1Vgs3hFveyz3uNE8SKr8Zl3N25kzWhg9wWy7oyMTC46M9hxNRoa9rgTDyCX/rOSpkB9+E5hILDdch+aoU0UEf4TOxoFXrxZ6dj476fHjaih/XBuimA7N3LoZ0aTzOXAXmMbo6AKV1EXpZCwnwvd7bjAaAvchBZkf0Y9rIlLAcGVnm1C9xS/B2jO787ATuZe4+z7iBxELrNcPJpq/JqiCGpg50GVrpgkodYlH1nc8ixgtJRfYaOMe76MwDAE5Y6pjC2fBKArLcTXzec/17UfsV27JzRJiPEzP2UafJEpylS4LQhqRR8cTHzmswr70F6VbRecMNZXCjGXiya4fasyRHOTeozkGBWDu/pxp1dD9QKnzprehf0nj2esCJ9iNq+933CbsWNJNMgaGfdrTqXWt2WEZ3ZT5rA0fHyFyp/HMQ0xDbaKHx5+femX90BFuh2YthFKZ2G2mhb8F54pdm8DgUtlKPYucSSUtOgHsC88YTiDBXgXCLkryVXNxQlgujSUV30I3v7HTjheWGdPiA5vldywfMLdeZBYiPAC0x+wX+/UUW11DcgEa1sQRKYW53lJ5cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(366004)(346002)(376002)(396003)(86362001)(5660300002)(52116002)(186003)(4326008)(7696005)(2906002)(36756003)(66556008)(8936002)(956004)(66476007)(107886003)(2616005)(478600001)(54906003)(83380400001)(66946007)(6486002)(38100700001)(8676002)(26005)(316002)(9686003)(6666004)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/hwnL3dqZWEvmtVGzLdqH05p6Npac6jhIC9AB+aJJO2ilUCevGO/kBMsDeiI?=
 =?us-ascii?Q?EbQbrH+DiL085rW0cw+a1BPUPUAQ3ge5WgSaj0YYMDGp6Ex0D3am9jqpaaYO?=
 =?us-ascii?Q?rPKwgPceDDX0sNk4GqPXXVFCut8BvGI7R0FcKSkpL/PllG1duyYDSKy3XbeT?=
 =?us-ascii?Q?kbL4oEC6HpjKN4FGhx4e7nBpdBAsEHswv3z95wZU+f5pxnZ8ofuNWHHulT5A?=
 =?us-ascii?Q?nukLfvM5fJSMzeEfKnapvpH3Se9R07CcrfVT3Np5yWhwOs5gFivO0E8ka1YD?=
 =?us-ascii?Q?OmRQrpZ05zDcQOIv+CZKnbykVSwv8xfW8+56jcR/6l9T/dWDFVLm4u+qrPim?=
 =?us-ascii?Q?fQj0FRjcz36vBKuaU9tDjRENiI37M2pijhh58blH9ryv+uGzt4UPkMZW50sS?=
 =?us-ascii?Q?GQq27ijRZsT49KdGYVdis7l3YX/04Gb0neAZ/+sDXIGRi4ZX5qpZCZqb8Ie+?=
 =?us-ascii?Q?/ICZijcD12ySg0rGFHFIEW5KNrgN7jp03R5XfP3F/otB674Js/3EwUeqjEeK?=
 =?us-ascii?Q?AC6+zfS9tvCOAZ2ZryLdgYfR3o5Co69UfSEfRg242Zo/DXl9Zw1d0vOV7LIa?=
 =?us-ascii?Q?BDOa5x13lFeBR7ULwJWMWrgYnVyWWmDU8uIo+kU64eydIirDoIwAa+dgOB2g?=
 =?us-ascii?Q?RVZ6hFP3UWZQ87ND8FDRn4ZxA/xolYvOZ32AMjiXUrBIPzgqmbJ1+fQZwpQU?=
 =?us-ascii?Q?ZRpmI1S+oJ6QwGMDSwl0Qn3wectv95IXGFT6C/JRA/SCHTqPUlUah75HuT8H?=
 =?us-ascii?Q?emABZt0nMe8Tc+iwAjABKpYwbJXk5ajYMJ+dGQq+YwPIfaStuz7a6zZdC+k9?=
 =?us-ascii?Q?DJTAAn+BkRSS46eg7Pav1HcR/vWUUxbApK8vr635n8+uOakrYKBL1gd3pE5J?=
 =?us-ascii?Q?qr5PRQYrr0W0feGxXVDiRRuFVFqn4OsDAoQn6txSIzRB5/k0/k/EtqcfXNMq?=
 =?us-ascii?Q?6N+Zv9yHV6DeowjwXSNMgEPmQo9uifD+WBwtSSJQ8ffsRJO7bP32mAFICI4N?=
 =?us-ascii?Q?eaQOoxwDqn6evKH9z43Jw1j82ka010bbGrd3FFh4VfIe3jQ6DFoBqW0l8OO8?=
 =?us-ascii?Q?zDYrj109+MdaVW7CY1INXr4601GaBo3iIVN93UhkOcHM3SmLFY0i/WhtUZan?=
 =?us-ascii?Q?Q3gTU7Chi6I6nPeAikmejyrecaj730/ghYo+hPEmbZb5YwOAdIEYzCoRJv+2?=
 =?us-ascii?Q?5Wr2fRGTPDeVGNXyu9D0+LZDoDxx65Y50xw/sBXbV9I9/Pj8UMOPtaq7qXU4?=
 =?us-ascii?Q?hTkoxg49oDU5nLIpOexSYf8TIQCpw7lLHx0/aKZUwhlhJFixUJQknS9jc/pC?=
 =?us-ascii?Q?l6nvXIKymflaq6HCo/si9Kml?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8231ba64-346b-415d-de1b-08d8f2ba409e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 13:55:03.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myap4Pr/xnQY0JaX/SrFKPUBQnt8c8aBOAB4VN7hhY3kGjceS8s9zN1KiofggJPOt99VYe7f8a17PdQllphFzNRUSkJ4TNe+3y7w7h2zVu7G0oXWdpi0duDvRugErSlf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6618
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The call is from an ISR context and napi_schedule_irqoff() can
be used.

Change the call to the more efficient type.

Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 1c38c38..8ebb653 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -209,7 +209,7 @@ static void hfi1_ipoib_add_tx(struct ipoib_txreq *tx)
 
 		/* Finish storing txreq before incrementing head. */
 		smp_store_release(&tx_ring->head, CIRC_ADD(head, 1, max_tx));
-		napi_schedule(tx->txq->napi);
+		napi_schedule_irqoff(tx->txq->napi);
 	} else {
 		struct hfi1_ipoib_txq *txq = tx->txq;
 		struct hfi1_ipoib_dev_priv *priv = tx->priv;
-- 
1.8.3.1

