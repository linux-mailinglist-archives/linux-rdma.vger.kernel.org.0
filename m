Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E27609F14
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 12:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJXKbq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 06:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJXKbp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 06:31:45 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BAE54CBE
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 03:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/0BvDCiOXEmNR5yR57Xu0q/P2Ue5cvpu4KKB2699h45BGL49/ozAj5Qmbf8xiElYV0+jGWJ7kO716Yww8phn0hvIDaeF0SZYSPzlK2KH8Dbj1HNz+o36urNVRPIme/vgjhSlRNdkqMvgltiCJ6UFkUGTxRcW71bltxaoFrVtYjU4GX57iNV5vmvbtm+n+wg+3qNA07ixpw3KxRIbUCXD8YWsfM/xulvwnazFxCO6HvGqA/A0l0VDB+YSrdwuInPw+HW2tWAWRydnO94h1In0fud22qnsGGSDuF4r7TCgL2Mkt7RWKorEEEw24E1LUdlo71NpxZhTm70qJxqLXZsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ7iJ9PItWg5ODmjZOeLeoIm2gthf5XT2xNuhCVZiGk=;
 b=IA6lc+ZBJlOHB4cLxgIcv53JtfN302qKWeYyumeKtVG8HszGYKd2+Syzy+q+usvgiFosMApPhu52g8ZAYzz7A/n3gCTywDYEjaQvEwEx5bqCzvvPo29XkFw0EtluAoRVMZnNehqKdgMHem7QLIQix7rwA7zGjwIbQQfC5DCg/iejQEJLcVnPDIpAUNHytp7GThXbu4yIiASkug3CUlujLl/m9MI4wTluX/+84oeK5yrhgVHyuFHNjmiGumfd375epAZfkxdom8MNdP2pBYQfTcm+icgIYawfNCTBlgTwHvkCXJPc6gsZvLToxt0/xI3Nthrx5fuGKdId+ZR9zwDw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ7iJ9PItWg5ODmjZOeLeoIm2gthf5XT2xNuhCVZiGk=;
 b=lJTswxKbpvt0q24z8k53CPDVnq5hDLbxo+77WAKs71KBzZyF45g17PloTQojZ7uteth5bLayNfX/+c1yzfainyi5x1vO+kLFdzoYnaNw/dLXbyDyTNH0uuBR102VEPO36X7r9vppWepPJyQRAHdbNN/ANgNI/KWuldpDblBYOSduPTUmT/Fw2nhf5gvSJgtq2ZKzT4aI9smBuWILknlL6z3ydAnJYeG8529EuXr+BTqhbOOhMrqTGM8tj4+t5WJbQP7PsQY4qW6hw4Cz47BNsQmG93eqw/0DCE3DM9M8JnXFuL9Rr5TNexj3em6DPfTx8/eC8YSZ0kj/5oyfRvZ06A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB6507.eurprd04.prod.outlook.com (2603:10a6:10:104::25)
 by DB9PR04MB9308.eurprd04.prod.outlook.com (2603:10a6:10:36c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Mon, 24 Oct
 2022 10:31:38 +0000
Received: from DB8PR04MB6507.eurprd04.prod.outlook.com
 ([fe80::6f67:5478:53f8:b14e]) by DB8PR04MB6507.eurprd04.prod.outlook.com
 ([fe80::6f67:5478:53f8:b14e%5]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 10:31:38 +0000
Message-ID: <367254f1-9b74-236f-4f4c-fd923d71250d@suse.com>
Date:   Mon, 24 Oct 2022 12:31:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
To:     linux-rdma@vger.kernel.org
Content-Language: en-US
Subject: [ANNOUNCE] rdma-core: new stable releases
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0174.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::13)
 To DB8PR04MB6507.eurprd04.prod.outlook.com (2603:10a6:10:104::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB6507:EE_|DB9PR04MB9308:EE_
X-MS-Office365-Filtering-Correlation-Id: 59aa4640-fc66-41dc-833c-08dab5aaeef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCmr8RglrVaDrGAtjEw1KzVdzx4eTgeGNrP5dsYjDE3DCbpQLXJOwBd3C2sRIsfa3zvATq0T/QIMJXO1ZM+lpv7YlV7t8PvvUFXozSY0TFzD/CgBIEZeraesNA0YdBD28ZamUiIgHr1nz7y8s0LHbT96NHCyOVlgjNiW7JmnELLNKRRnsZZQPNX1EeT8Cq18hSjaMriBUE8vZeU53DQ8l53HbT9Wcg29lVi18pzxbpvBCixx20jZ1/Pnqc0Zg1IBOT+vE17Yyg4F1B3Z/YTnGcf2Q5cRkFU4x8TDj0DhEu/Jr6nz9rA+cTl7StPVZ/CV+myXlZ9cCSGGg5Mps0YQYfAnqxoxA6x7WyaIv+ZnGPYChCCGAQgVlOngDfVnWiZA3XZQqOU5k11Dt8YZGMqD4q7bnLV84cZE4tBfuDVvO/hU86TGzvu/JUA3wZuiR2t+hcHZLUxVTRpWVregek5vNpNe+2GFuZvn90okNh3I3k/gPzCnFEBwYW13ikYS61UMgAFfajHDTK+WcHnwhtwCabzvIIj4McRh0KvPIm9Lgym+dvVxV5B5gRNQks0DgscZSaj+YnqYUGJCGfy7MMRwpCIgkKUg2QbxT+AEh3O/FZ/4iCDjWi60cE1vGmGWxS2taNbBr64UXS8whF7v2V8nEHpv68rbzQb9eJW9LrJ73rMFiQKFt6GNy7dSqieNjL3ULFRd0pff+Y/MXRWwNAgYWE9fMndbE1bavcKo3ndQ5AsTcHVABR3q4knw9BnprS5Nh1/2ZfTrLglnBaXfbzBrS1nv6tasUl26UGHrS5shVw9JmzxGKGWQyLrbWI28+Yv8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6507.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(41300700001)(5660300002)(8936002)(6512007)(26005)(6916009)(66946007)(66556008)(66476007)(8676002)(36756003)(6506007)(316002)(38100700002)(186003)(30864003)(2616005)(2906002)(31696002)(86362001)(83380400001)(478600001)(6486002)(966005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTRCR3I4bi9KVHBlME5Nc0FVNHo3dDVWa0xaeG5zSVhWMWRBVVhWZlNvN0Z6?=
 =?utf-8?B?aXducUx6Ym96TVFrVTNzMUp5MGE3Sy83dDR4MVRsL1VKTE5IRGdTcnlQekxE?=
 =?utf-8?B?d1l0K0d3Wkdtd0FmbEZSa2F0ZUlmanc1UHZSMjNDaWpxd0lCdDhKN2xEaEFo?=
 =?utf-8?B?T0RyMHErdzFieW8xZU9JbDRxL1Q0MzBKVXRSQ0RvTDdrWnRXajVBbTJuYXZh?=
 =?utf-8?B?eU9welVOdzZWQ0s1dEZ1RUV5RW4zLzIyQnozc0dMZzBIVjRvT1ZQemdoa3Vm?=
 =?utf-8?B?dGg4NXh5OFlDN3NWN1gvb3hQbkpXa1UvY0xkTXViY01BMG9xa2E5b3l5ZmNM?=
 =?utf-8?B?aWFxTi8vZnR5R1BkSXF2a3B0VVVUeHFYRGVUazlic2xidzdsTnVtdDlteE1x?=
 =?utf-8?B?TjVHOHQ5SHdXRDNHd0F4SmR4QVdLMmFxU0ZxTUVQNEgycG1aR3ozWWFXdENu?=
 =?utf-8?B?ZE14SndUMW5ELytvUjF0U3pEN1kxVUphZXMvZW1FQ1lZMDI5V1QwcklsZjFX?=
 =?utf-8?B?R0czWTl3UEZkc1FsSW9saEd6c0M1aUw3MnNTa3RYVVNsbTJweFFyQmJMNDlx?=
 =?utf-8?B?NjgrcmRrYktwZlk1U3p1VHN2bHZhYWtCNXJNbkhnT24yY0tTOGtqZFZ6d2N3?=
 =?utf-8?B?WVFRSW5YSldzVVcybzJqTkh0WGo3ZkxRV0dCVWxNTDdWZEcvN0gxVEJKODhh?=
 =?utf-8?B?MFF3ci9kVE45UklsdllQanB4V0I5YWkxZVc5WnJBL2ZjUFprS1M4TFFNZVBk?=
 =?utf-8?B?ZVQrUmU3SjE1M2VMNjJpaUdzbllKOUxGaER0eE5MK0JGdFZvMmtpajlaR0sz?=
 =?utf-8?B?S3BSWU1MSmxsVjJjc005ZXpGRHJtM0JwS2wwV2lnUWc2RkVLZHh4Si9BWUhI?=
 =?utf-8?B?SDJOa1dRWXhSd1hqck55QzVPVkFrOTlXRjMyYUQ3UHY4SmxNSW5haFY4ampY?=
 =?utf-8?B?amlXMUFCR3pmYVRSOVZpaHk3d3ZhN0doTXJ2TjF4SGs5cGZnZ0xJQXMrQ2NY?=
 =?utf-8?B?MDZUOFV1ZlUyZGNnUzNPZjZJeEcyaVk3L0hPM3R1eUJibk1DVFBHbUNDVnA3?=
 =?utf-8?B?Vnl5dDdKSWNUTnJONnNTbzI3U2sxUzlaMDNYdVR0ZFRUTUdPWDd6S0c3eHBq?=
 =?utf-8?B?UUFiTDY5ZXZMLzRFanZVUDZ5VDluZkdualdtTmlINitoNlVLZDYrNTFXci84?=
 =?utf-8?B?QXlmcUJOeENVOWN1TWRJRzdtTGlxNFpJbUFNQ2w5Ly9pOTJyRnp0bkVVbmdH?=
 =?utf-8?B?b0s4YWFrckhCbStvTnJRWEp2K2h6R2lJZjVZNDFicVh0dHVLKzVKNmZxMU13?=
 =?utf-8?B?TE9BNnFlUHR5U24rMXlMdWdrM2Z1Sys3ZU1sUkNRSndPdXZTcGkxVW1wMmpO?=
 =?utf-8?B?Z3c2YU1IaGVVYU9qVk9tRnFTZW44Ny9FcGMvRUJjajRpdStTUk4vb1F6UE5U?=
 =?utf-8?B?UVMrWGlYSXFtd0c3VHAwSzNJTFVMZmtJdlkzeVl6dXd5TWdjK1h0eWFnSUQx?=
 =?utf-8?B?Mi8xVGtFUjdNY2pRTGVrd2h3aDlEOUk2Y0c2U3Vabml5SUNMY3FsYVNEN1V4?=
 =?utf-8?B?aGt3YThhSnczR2NNNzRZN1hwd0NCZjJ4VDRMRWNiemVLMFpTR3VmVXdMc3Ux?=
 =?utf-8?B?c2dRT2FrOVBRN1NrTEx6cUQ4UXEyS3duc1N4RkpTUm5KVjByNlRlTm5aUUJZ?=
 =?utf-8?B?Y3Q3aXk4dGdQY2xQY3lpMStRNko1QnV3ZEFLbGlMckNGWDVObTJrNWVUbjVJ?=
 =?utf-8?B?YXpKVE5oQkZFbjNMVy91b1QrVlZtM1l0QzE0cSs0Q0Q2blNHem40VTdhckRP?=
 =?utf-8?B?OUlCR1JkRVZCVDVDMWVUT3ZmdkFXSWlaMko4UXhhbzQya0YyY2czVmV0eGtZ?=
 =?utf-8?B?Q3c0VjRLbVI4eG9GL0F3SzMxeEk4aXFNSkdheTM3NlA5YW11dmREVE0yb2tN?=
 =?utf-8?B?dmZCd0dtMGVncFlBdlR2ZWtQaW9Ia0JnTTJGbHl4bDRKOXhpa0NJN2s5ZFoy?=
 =?utf-8?B?b3JWNGRLWTRHRnJubmlEaU9CbDhMYUdxeFZML0RLaklFb29HZHhxT0htVGN2?=
 =?utf-8?B?ckc3Zlh0OTEwNEc4aTV0SnRWQUtza1JZcHFmeFN5SmtnQVR3bXBEOTRIUzVT?=
 =?utf-8?B?Y2h6a0RNSEtQYVFVR3U5WWJBL2c4SEZkV2Z0ajBoMjF6anJoQWY0R0pjRnNC?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59aa4640-fc66-41dc-833c-08dab5aaeef6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6507.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 10:31:38.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG7WoKyXsPY9J0B1QiZLp+nKsHMhdHKXb4oIiRe5NJZiQKtNP22WGPkFWFtaxZzvWU15S9iAfgntgmrW+l1V0W6A9DE1e1GwQVeMlPc+nLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9308
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

*** IMPORTANT: This will be the last stable release for branches v20, v21 and v22 ***

These version were tagged/released:
 * v20.12
 * v21.11
 * v22.12
 * v23.10
 * v24.10
 * v25.11
 * v26.9
 * v27.8
 * v28.8
 * v29.7
 * v30.7
 * v31.8
 * v32.7
 * v33.7
 * v34.6
 * v35.5
 * v36.5
 * v37.4
 * v38.3
 * v39.2
 * v40.1
 * v41.1
 * v42.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v20.12
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:46 2022 +0200

rdma-core-20.12:

Updates from version 20.11
 * Backport fixes:
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * cmake: Add default for SYSTEMCTL_BIN option.
   * srp_daemon: Detect proper path to systemctl
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS84cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZJORB/9xGGJ8hXtWt5I1ZHaW
Q6kWpTL9dJkTtQ2WjJ1XZ6qJRB0tEzNQyL1on1ZVmZVfAfycMUQdlBMNBHAPkVEN
TT2hL/S9q7qve0AmIy8QKjbEkhq8pr+VQGWL5yA7UV1pObjQ8FhkX+nmbN8xK/Zc
JpA68TIuFBXDw+eV6nRdKPodOIUlq7ly3OPJq1KQQ+vO7MZ/oG92SWqZ8PYAbjUH
srtLmz87oVv8647L9xI6+rs4tyLa0c9WiwrzVy22wDLcH7O/+eG0+k0IPws0VQHC
IQJrDcxDUsvhqJSMyrmkHlIwliyOa2FJsDWi9W+b8NTX557XFjgLexXCRexU14FQ
mNh+
=HbL/
-----END PGP SIGNATURE-----

tag v21.11
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:48 2022 +0200

rdma-core-21.11:

Updates from version 21.10
 * Backport fixes:
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * cmake: Add default for SYSTEMCTL_BIN option.
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9AcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBlkCACFFHGptbvwDjGx4AuR
dcWDMsW9Zg1gIX/pEw3J2sCp8XfcZ9VvAcAm/VX52c1pduXBXHgG3cjFz4KMlYNN
yxj8XlRxj1iNfIxMrP7u9XT3itH84HFio5wIlbDMq/mQ46ttjlXCX0L8Qgt344ht
7QN1A3YAK+fKnF7m+c76irCqYEHAzkeg8gbvnj97q9vgE0lcPlHDXCL5r7Wrpj7H
PJFALf1Mnp1K5mw9a2+sKGgIYLes1OszCPAZ+g1l8ENOWEQqlCOQAYdCFr/jG5rP
rXSkkh5/SqQS9NikvvAtdApbVQgHThBy1kkhPw2yNW5x7Wcd9uBJUCxELsExBnvy
kVyf
=/TZz
-----END PGP SIGNATURE-----

tag v22.12
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:49 2022 +0200

rdma-core-22.12:

Updates from version 22.11
 * Backport fixes:
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * cmake: Add default for SYSTEMCTL_BIN option.
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9EcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZMQHB/9IvVeZH7PoP5rzf81z
dHTnsmyKjl+ys54f63a9X+qyMg7QMi4y708gLKThDucwoeGzQTEWW9GfHYMMOxSO
avkhZzl/4TA7l+4rEKwo1yqayage3cTfNGIxpMfucD7Vzn+DursL35+vLbAXtEFY
0I9aGu3JJWqWmZYIddu8BrE4sxGHNdRSbW1A8wPpLgvg6ZCs5x4QWTlLsEt3E7CN
ZSjDA8vbLDEVHiF5xVyMyTqUcpvSOfKUJNsjbLgqyZMwGL5N1sXkzpr2M1Ce0VjA
mqK+AcB2ef1eTF0YLlGJxhgrrX1NZ5kn2tIG7V97jPsEyRXzuymkv6TAWCeL1fru
OPPa
=ZoYi
-----END PGP SIGNATURE-----

tag v23.10
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:51 2022 +0200

rdma-core-23.10:

Updates from version 23.9
 * Backport fixes:
   * Fix spelling mistake of underlying
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9McHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZD8HB/92nAOA/g7OI/iqEJ2+
V5GBKRJOUBbKtcWixsp2PmJ9HvWE1aIJG5O3TaX4OfLWrbYj0g+W+7mhDkeakqvM
qlMCjcl6S8lDQtYymOikAbONgEpCjqSbuXpGMjK2QUKPdBEqKA+NYR3/0FcTOVML
spbY4Ge8ZjEByrZmet9554uR5xcOCMFI/nwp6JJj39rfT5pcMgznEvLFxTjr5XzC
5aTwdq4WUBHfpEhj/gpkJRRAJbqRDVfMX00LddVmglcqD+861g7k5g/avhYS/XAR
ftJvZrk1mMH9RmfA5ZIvJYuVsV2oTArMAy3hr++zmJNiLGajtWqzPaIdNc2uzU4N
LY6s
=MBcR
-----END PGP SIGNATURE-----

tag v24.10
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:52 2022 +0200

rdma-core-24.10:

Updates from version 24.9
 * Backport fixes:
   * Fix spelling mistake of underlying
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9QcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZEw5B/9iaXhl28FTjtD9ogDL
ROX84cVRT22cZbSp7Ar2sa8aUQMdxjA8q4wE6nP9IaEGx4g7zkgpqYP+cJIor6oB
wngyRNhz7AaN76XsDIuUdz8yI+3HfRvhSEldhoURGSSDPWufIoAKtbFuEgu6Oqou
mwxIeAAus/CPTsPlo5RhhQg2sOduHS3kHEiXYySl0NPAGjLyrPTliQesaKYZOcr/
YCSowSuQyK/0VSK1c272gTZE+AlGIScdYtDkUtjumKgaXFZoez2nPKQZYHQhWdUb
2x4yV28wgm22p9yOQblqiGdF+x886dFi5rUCfB5fU3e1h2IUTODfRdguS2i330dW
/+H6
=1Max
-----END PGP SIGNATURE-----

tag v25.11
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:53 2022 +0200

rdma-core-25.11:

Updates from version 25.10
 * Backport fixes:
   * Fix spelling mistake of underlying
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9UcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZP/3B/9q6VC4VUjwm4OIwSxO
uV3Uq0nvrWEr4orto95OVJJPuEMJYpe5TODqXGtcoSenWaTymiQOKicKy4Qx8lOX
3/yl5xfSiEq4xlKt2ff/KuVDvDqowd+woMA3b6KQF28hy11CZkp7/lz3/0J6GRzp
yUkO4Cdoga/sc6GQM/m/zXToTXcMBXmZX2//TTR5kl6fjBM5+NzMU4sIlw94uVOT
sf8WTgnOXiwOMxb7gClm5i9j5JSuks4Zv9XnJjqYP0jK1AJoKZukey4Y3hO9+PnA
sCoJw4YxlRaDwcBt9WJSHR7IJOQw9gkkaynemgn4WN08Q6QyPiQzllSjJe3P75tO
puIj
=uRpP
-----END PGP SIGNATURE-----

tag v26.9
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:53 2022 +0200

rdma-core-26.9:

Updates from version 26.8
 * Backport fixes:
   * Fix spelling mistake of underlying
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9UcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZK2/B/9lGeNY/Ci4dc/Rcp3U
rMxVXWTeCgp7+spFSc3+YLnhvskmAj6UTYWuYob1JxAF9kSw6MKUCxozwnB85Qs5
guU8WDkoF63TtsbEBvoiDXAefFYhlDkZx++M2EP6py9ovf/tNgwaiJJjMYwBFwqZ
LoiL+Ky7aVfqt3ab4M5UoTPWT5msRwmUZxkyNmteKZPbUzbuUeX2Y+V4c+WyDkja
nCUwKZYD767HbumQtiQuNGsDFt5K0Kiiiu5fGxFmFScUfFCw1hy27o4R+e7Cmo53
M6kSHr8689YG1lTyuiq+q+cxa+7Ob0Zo/BhqXKaNyn7+Bp8+9/PHFvaw5qvCKmNJ
Svyi
=+PDX
-----END PGP SIGNATURE-----

tag v27.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:54 2022 +0200

rdma-core-27.8:

Updates from version 27.7
 * Backport fixes:
   * Fix spelling mistake of underlying
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9YcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZK/DB/wInEKuwn/sVeLAqGUr
nA8gBlZ5+KWiZb/w83HXD/7CRTeAMXpEvyV6k7pYmwvyCC7BJcJcvQ0t+Cm0VgGT
Wr5Qp36d1QpHPjtO8LGPJ5N8T+1IOItTGrBj0WjBPCqBbcnyJrPIZFxiRFu+mFIj
I5hnKdVSgcu5d0Ik+IBW63E7v7rT44hRcsIyqthPyiIE/k2p8gdvAnh3QzqV0o6l
LPWoKIOwKhdvlGocLi3Re9oRvNHKz8aG+jy2aIkXROsLXEyQZOK2NCIDgqkf+VJJ
JbFm+Qcf0EGV9NwjoaGfAiDJ5eKnpeeTqCZYNkHf/IDLfZRtA5eoQYZ2qS3cwkEl
pC9e
=AhGs
-----END PGP SIGNATURE-----

tag v28.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:55 2022 +0200

rdma-core-28.8:

Updates from version 28.7
 * Backport fixes:
   * Fix spelling mistake of underlying
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9ccHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZKlsCACiTPzhxQV1OrEvjVlC
yXgMrw9VxfaIDRWc/JiTB+Ejzvj2BIHB6vKahhX/m91sz0HNyAHog/qYeeRgEx2w
wu4GHubLq1zpAZE0GMYKEW/vvyqRaSv8+KuW3e1wa6E0Kw9ss902ILM+ryTQRkWK
yv0peoWqsDoBIZ9OVKNBuFg7+tK/kZFFnwznnh8wTFtKjd/FL0lf8C+++CymFwfa
yu5Y9VWaaxTGHbSAPr/aCQS+Au+zaT17Dwa/gBDD5gGjBWDnlqvXhZ88+6nz3zSV
9g97eV79SzRClWezY7MDdGljAYB+WP+0VgqOd3JhUMocU6aXaMIDnGoLuTMuOJbG
Fxpm
=FFcQ
-----END PGP SIGNATURE-----

tag v29.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:56 2022 +0200

rdma-core-29.7:

Updates from version 29.6
 * Backport fixes:
   * Fix spelling mistake of underlying
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9gcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZKk1B/42xP93g7qw9ioW7Bdz
vy8Rtn7XUCy0owrTRVuai3i/KGt7BFdAhuLHlYNCmCSTlNGdOCoywJrIEyP4ACkh
JU+c5pRyGYR9ebPhuQLJG4XsM6CfuGSFi2hUBFRK6Srh5w2xZBm41pOVsXAjZx9q
57cipENqRdbNJ+GrLHmzwVx/dVNAPQrmGqmvwGsaRbSbDuXKDdJ70mpa6fjQTk83
Jiu1Lw5gMhJcxQnQxWM8r4kd+Xw2JgviJbGhD+P+p1L6WypEUA01yhw3i58KkoKY
wNfU1/t9FKpbyw/wNzzOjBdBCS+vQXwY6cD94KtNPUOAu/QJK2Vb+NdiAvCsRfCg
6ASA
=bRxD
-----END PGP SIGNATURE-----

tag v30.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:56 2022 +0200

rdma-core-30.7:

Updates from version 30.6
 * Backport fixes:
   * Fix spelling mistake of underlying
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * cma: Release allocated port array
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * librdmacm: Don't rely on IB device index if not available
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9gcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZEduCACwYT30RkB577QIVFa7
4RcIcGuPTuW0o/tHfN54WSRfI+5GShmRFXOJkjo1yVb9C/roBBX6NA6S0XzempYp
35rKgeiuCEKD5wGphD9a3RRDiuG1K3CA6iXo8Q5mN7ty9F/CkEcU9q4XXev1/ATj
TY2aq+taEbkdDu3zMzYN1uNNYvBiR0syTOi9J04vupJ+zBkEhzk6OgMR6gTfpHNw
sLCJ60b2VHoH1eT64bPu1/eJk9gZ9wY0uQ8Szr78bPyZffhVANTM+E+e6M/4jgu4
iC9SEyvt9o0dNwsWmPa6x0SosoFHA8afCUKRYjudkrCnwBfliGc5gzlMkUX9DOIo
OBy9
=98UC
-----END PGP SIGNATURE-----

tag v31.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:57 2022 +0200

rdma-core-31.8:

Updates from version 31.7
 * Backport fixes:
   * Fix spelling mistake of underlying
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * cma: Release allocated port array
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * librdmacm: Don't rely on IB device index if not available
   * cmake: Add default for SYSTEMCTL_BIN option.
   * librdmacm: Make rping with external qp compliant to IB spec
   * srp_daemon: Detect proper path to systemctl
   * cmake: Fix cmake link property for static library
   * redhat: fix CMake flags
   * verbs: Fix description of manual for ibv wc read byte len function
   * verbs: Fix a typo
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9kcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZLXAB/41jAuhdAkuir2AeReN
EB86b+XM+K7suKLxVgHtnJRvtYwnQcQ1uN04p+R3zmH6AvDe8ApsG+utg2rr/1Uj
roNmV1jRmr6vokQFw1xh86oZh05ZDch5g1piV5iOx807BEEszaBVcXOEn2BIHPhd
i0nZS/U4G997drXlsrVSdCxi89IJEwANESHmXiP366ftCWy0xRkb7qnaliLlB7/K
t8PqCsq/s0hhRFRp72JYEugRopfvmyYW8DVluk3wImy2ujHhFiGjjxVPxPvID8Nb
Yb5G1AOPyRghTVrNGyZhsQZfDPSE3C1JKH3iKykE0K0WibeRgPTQLbvYbElsU/kt
vyrh
=6Dby
-----END PGP SIGNATURE-----

tag v32.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:58 2022 +0200

rdma-core-32.7:

Updates from version 32.6
 * Backport fixes:
   * Fix spelling mistake of underlying
   * Install xprtrdma/svcrdma kmods in redhat/suse dracut modules
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * cma: Release allocated port array
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * librdmacm: Don't rely on IB device index if not available
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9ocHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZOGpB/9ToHyl97ItK5PldE+X
mL05zdfEGU7bOjba8LaDhO7AN5v8VS/RcRTYuQ0gYSeE0DAWr9yoQRYcn8HasWhF
iTzvGi0pbmARS6TBdPDHFJsh6uQgL1gRbBumDeoaemaFu/8VyYnBgnoWHDyUTjdb
ME6R7C1Ol4UM2UqKmL/0ijjndaTSwpvCFlOAMlATbotg33DDStQZjsePIEfOU+6z
dmpDr2z82QFFRasNp/QRLteyKp3UMl8tsLJmUFMDoY2h8/lgr22fRYt0Uf1HwlSt
Q7sNpK3S3BeQY8T8utZq3m83GwfftpVxUz5Ul8yvGWN6c80oxdAEkC3moOLUYBpP
9gWV
=d8p5
-----END PGP SIGNATURE-----

tag v33.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:59 2022 +0200

rdma-core-33.7:

Updates from version 33.6
 * Backport fixes:
   * Fix spelling mistake of underlying
   * Install xprtrdma/svcrdma kmods in redhat/suse dracut modules
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * cma: Release allocated port array
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * librdmacm: Don't rely on IB device index if not available
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9scHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZDAxCACxKz6JmUm5MxILiISw
bSs9N/taSAg3hAgF0NdTOXsHeXLq43kAlGvcnmKDMfh8A7+7snBpfz9LSAgzmAKZ
znKn3l+/Qt62wgnfxjvTEyW7pS63jjwdEPKgNbyDwCp+WoNjtJQcHYTvql0t48fT
M7LFQvSvbBf6y7BQt0C+qWeR82aAQdBkx0qZtpO1vq2sp/1vn3tSQxpWmwoHDP11
V8TaLuLhg4o/ZqdmxaYYUnLfpdhrg+Zmj0uTCI9myQU8XARimubI+h70xR3hRwc9
aQ+K8IqDlVSH8fxGIy1JcIu2DFGXJPaBErF9JQZyOtzI9rJY1LdLJkld2IgURpS1
9iB2
=0Fqr
-----END PGP SIGNATURE-----

tag v34.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:24:59 2022 +0200

rdma-core-34.6:

Updates from version 34.5
 * Backport fixes:
   * Fix spelling mistake of underlying
   * pyverbs: Increment the correct rkey in test_qpex
   * Install xprtrdma/svcrdma kmods in redhat/suse dracut modules
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * cma: Release allocated port array
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * librdmacm: Don't rely on IB device index if not available
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9scHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZJ1TB/wM8edLD9v9kCj/8YXy
2KvUWSOiKg3xYLDYg2An1DkvKNYvZCsnIeJ/mxnr78jey8S4jZKtiLWN0qIjWPeG
mWqTETn1biIdfZgbZnNtDaM+hgrwLcCDw7grlRoewm+yN5xAoNyoOtS7R1sh+Lr5
zIguLrX9goZR88SprN2s7cpUcbF0P2v5FxHEQdJiDjFzoRooydi2X5txEK6DC8rw
7MRcY78yYjwqVjZy6tukay/uVdiu9fG2wkms6WJWhbNw9ZehqA1vk8clT3uMzo3L
mGJR0JrBXXbwUJ9XXd5xy8c+l12U1RSx9Mgq4YMmYuhS9HP7gZsuL7O0oIC+hC5n
DbWx
=nopK
-----END PGP SIGNATURE-----

tag v35.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:25:00 2022 +0200

rdma-core-35.5:

Updates from version 35.4
 * Backport fixes:
   * Fix spelling mistake of underlying
   * pyverbs: Increment the correct rkey in test_qpex
   * Install xprtrdma/svcrdma kmods in redhat/suse dracut modules
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * cma: Release allocated port array
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * librdmacm: Don't rely on IB device index if not available
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS9wcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZIFFB/99TIcUv/epgFClfSmg
ezSN+DuBzJemHu3seUOVbVjQo2MF1IX5vJlAmij6CdVnSEIWK5kYSA971hh8vZ5G
XFVPj2TvSW+zsZZaGRoCVbEs3W9+7L74KYKXLtOZ865rSqviw7fI9l1//EI6VVIs
eazOcikW3puo8t4uqy+KRly5ZAk78eKcoMtUXf5C7f53j1GTwQ4+u0evA3WUOckw
fDqNsj/O97hmnhPi3GXpBPWplAVcKr1yN+SbBhPxEJoVMDaAhhRbBFk6Mbrw1eRO
BYDy+6oRTJX/1Iz064ebo76Fb+valgutfsDzXqOi76sz3MJ17k7lrUN1IXuGyHN4
+lsK
=MXYO
-----END PGP SIGNATURE-----

tag v36.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:25:01 2022 +0200

rdma-core-36.5:

Updates from version 36.4
 * Backport fixes:
   * Fix spelling mistake of underlying
   * pyverbs: Increment the correct rkey in test_qpex
   * Install xprtrdma/svcrdma kmods in redhat/suse dracut modules
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * cma: Release allocated port array
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * librdmacm: Don't rely on IB device index if not available
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS90cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZIa9CACxQylMnvI26YwKDdrA
N7LvFa4WCjkOFo7tIqqNJJoUWfu+rM+GHAP7QmMg9iLkmX/7bP1aTJmdNTUSSi3B
wnK7YGiKqUkESeKbrKofzgyqkYtfOGzXQELWY/2L5m1g3Kmz7EwvkRZDbPwPnwzV
nlz6iZCneP5VlI7WJaWFNjH3z+EyYyUwsANUoNUbje9BDAMu6Qi3BtMRdzES1FUu
FTElmf9Q8SmJvov9ftPid1PDYM0gDg0hIZ+uCo0H9ybcO3BcFHnpQ4vPCgOLZoos
VBT0gH3k7jt+1+nM0ZnYjU2v2hs3WtmVnFmhHgEldFK6BN03l+WsIKtWRuAYeBp1
gL4N
=5d06
-----END PGP SIGNATURE-----

tag v37.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:25:01 2022 +0200

rdma-core-37.4:

Updates from version 37.3
 * Backport fixes:
   * Fix spelling mistake of underlying
   * pyverbs: Increment the correct rkey in test_qpex
   * providers/irdma: Use s/g array in post send only when its valid
   * providers/irdma: Explicitly set QP modify attributes for reflush
   * Install xprtrdma/svcrdma kmods in redhat/suse dracut modules
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * mlx5: Adjust Crypto BSF size if signature is used
   * cma: Release allocated port array
   * mlx5: Fix check for SQ overflow in bind_mw
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * librdmacm: Don't rely on IB device index if not available
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS90cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZH6UB/9bB5m440WkwhcQDTP8
5qtcw2LFFWaY1/yCMXeeCR/U1z1H1N9im28VlLMtaT8ndihLSvrdqf9hMPebWYz9
fnW3qnFY/b3ivRE9BUcmedk2Dkes+uJbq19y/2uRYoRgvkOYdn6CopwsIPCD1rHz
8J3lsFGmnrPaMr6dnmlo7T9fZnLYjeF3HCumpLzLK7S1inz5MRWy1sAiwRgYuPl4
+yljNz+fzdSVAqbsNMl2ZDonQyfseerQUqUYtxwKBtkNGaLnWE/Fg5FPDRz7OqZB
m+NUBnB1acLNiKMuLQ82KT6IHsqKVhOuTn80eQ01D/YFCqyMFFrRYZ+eiM0QdBt0
Y20S
=CXMa
-----END PGP SIGNATURE-----

tag v38.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:25:02 2022 +0200

rdma-core-38.3:

Updates from version 38.2
 * Backport fixes:
   * Fix spelling mistake of underlying
   * pyverbs: Increment the correct rkey in test_qpex
   * providers/irdma: Use s/g array in post send only when its valid
   * providers/irdma: Explicitly set QP modify attributes for reflush
   * Install xprtrdma/svcrdma kmods in redhat/suse dracut modules
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * mlx5: Adjust Crypto BSF size if signature is used
   * cma: Release allocated port array
   * mlx5: Fix check for SQ overflow in bind_mw
   * tests: Fix mlx5dr dest port test
   * tests: Change a duplicate field name in a prm struct
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * librdmacm: Don't rely on IB device index if not available
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS94cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZCQ1B/9iGdIA/Eel5vi3frx/
YkX72v95qZcOQ2OpY4mrrJbScTOQdB6s/yWhCEdIaY3YPvC8mwOWMu1QitOLbclc
2VpR9A3Zi8P5YGsrT5aaOxUg50XudwYSeGstcfid02iQ6hWz5PGxpTvVpOSWgbqa
YYBwztrOhr4tpFiwyLyhq3r4gzRsB+5ssYx4ZsrEtwgMKdaMP4E+6Aer3itY71cb
0xzgNRZgLEhkSVlGxutOE9sbzwKsJ96cHzRcsCFv2j4B/cGTnuFVIK2sG7zQwu+i
ZJlqYCIcaK489cCTk7OkrkH1DJdV6gtDnCUJEteuGQMVY5y42SYN6S5ebD/LxXnD
GZIS
=s57C
-----END PGP SIGNATURE-----

tag v39.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:25:03 2022 +0200

rdma-core-39.2:

Updates from version 39.1
 * Backport fixes:
   * rdma-ndd: disable systemd ProtectHostName feature
   * Fix spelling mistake of underlying
   * mckey: Use rdma_create_qp_ex only for loopback prevention
   * pyverbs: Increment the correct rkey in test_qpex
   * providers/irdma: Report correct WC errors
   * providers/irdma: Use s/g array in post send only when its valid
   * providers/irdma: Explicitly set QP modify attributes for reflush
   * Install xprtrdma/svcrdma kmods in redhat/suse dracut modules
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * mlx5: Adjust Crypto BSF size if signature is used
   * cma: Release allocated port array
   * mlx5: Fix check for SQ overflow in bind_mw
   * tests: Fix mlx5dr dest port test
   * tests: Change a duplicate field name in a prm struct
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * libhns: Fix the shift size of SQ WQE
   * librdmacm: Don't rely on IB device index if not available
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS98cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBatB/9L7BD72nV4xHeYdfM+
MY5/KO/DhcxVN539H2FICIuExJoC/jAfHUTnntzBSjiNmLoaxqsr6Q8aWWsmVnlE
LmnD04hGpdjS2Ww4L+Bq67cK7ytZzMIWppzL0StBBWlzS+58KHnPwcc4sKMkVldl
VBMRHEyfzlT98FiDumrlXmfdJSd3tR5R2VDOM3bYVYe3SpT1n1Bhe5RJGxBYDi4X
d1EBUBv1KqdW9UE92e03PrcrwupofEGfiQ3DGhwOHkJ3RZzonszlTJjUN4G/t8p3
fdHJ7l4w4xq/udvBvGudfjNToPYVeELAdkYiZtTGFae9yP9R1yQ6nRbVLkfQy39M
CrCt
=Em3c
-----END PGP SIGNATURE-----

tag v40.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:25:04 2022 +0200

rdma-core-40.1:

Updates from version 40.0
 * Backport fixes:
   * rdma-ndd: disable systemd ProtectHostName feature
   * Fix spelling mistake of underlying
   * mckey: Use rdma_create_qp_ex only for loopback prevention
   * pyverbs: Increment the correct rkey in test_qpex
   * providers/irdma: Report correct WC errors
   * providers/irdma: Use s/g array in post send only when its valid
   * providers/irdma: Explicitly set QP modify attributes for reflush
   * Install xprtrdma/svcrdma kmods in redhat/suse dracut modules
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * mlx5: Adjust Crypto BSF size if signature is used
   * cma: Release allocated port array
   * mlx5: Fix check for SQ overflow in bind_mw
   * tests: Fix mlx5dr dest port test
   * tests: Change a duplicate field name in a prm struct
   * rdma_xserver/xclient: Make recv/send WQs disjunctive
   * mlx5: Consider QP state upon mlx5dv_devx_qp_modify()
   * libhns: Fix the shift size of SQ WQE
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS+AcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZLC7B/9RpU6KdJYq5n6W6rmj
dHRRqpyRDEhshzUHk//ydFydgiRyeta8F5BG66wivXBZYX2j93DtoIFGnBwNa+j5
A6JZI0um+iQ5GqWr672MMz8TZtp1SKspvVAV8MtYY8+ah3nuRwoby2tOimZrM0GH
r/9IqchIT3PuiWlrgp8JtROGCjBYRtwCz1LiDaN/hlbwg7jLpG2bWLWehZTaFpeq
w6E/MvlKAg4Wkr9tuLgH5G0IXaZbBf/JseqtvQMVRjYDT/nWmXVn0oHa05ipvqqt
LH1OylM6u+EFl1U8/RY2A3dZu9hsdNHCxq7boyx+hj9TisA1lWAjOacHwYwtZOcb
lJhd
=eg63
-----END PGP SIGNATURE-----

tag v41.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:25:04 2022 +0200

rdma-core-41.1:

Updates from version 41.0
 * Backport fixes:
   * rdma-ndd: disable systemd ProtectHostName feature
   * Fix spelling mistake of underlying
   * mckey: Use rdma_create_qp_ex only for loopback prevention
   * pyverbs: Increment the correct rkey in test_qpex
   * providers/irdma: Report correct WC errors
   * providers/irdma: Use s/g array in post send only when its valid
   * providers/irdma: Explicitly set QP modify attributes for reflush
   * Install xprtrdma/svcrdma kmods in redhat/suse dracut modules
   * mlx5: DR, Fix missing comma in matcher builder dump line
   * mlx5: Adjust Crypto BSF size if signature is used
   * cma: Release allocated port array
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS+AcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZDERB/9dMQ+z4cUN37lfAxMO
NvTK9fkNDe9W80d8GZVZNIupCJ8/K+AE7k5XVtgsSMEOnflb03+/YkNXu/vb45Mc
foYy4FtOFRGyIace34gnQ9Qb1jUM1IaID1s+NqdEFJn+w/KOEiVIfDlC1YGKdSMi
J192DLcEcotku2krKS3GKiJnr/lKOqrD6EiKtZ6L+WzJZnnsbgeCcJ2mH+Drh0Qc
oCv7MnwL5xQY2Kme4uhz+Yl0BLAXvY5zm1FonT7TKJ64fxDRvv4X8Vwq/bsWUYqM
iuCWJ6e4otHJXUHAKjWg5JI2YaXgPMSfvMX4c4d8XZwgYRwGEW1lsyfUxm3OcQUp
yg7z
=GcgY
-----END PGP SIGNATURE-----

tag v42.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Oct 24 10:25:05 2022 +0200

rdma-core-42.1:

Updates from version 42.0
 * Backport fixes:
   * rdma-ndd: disable systemd ProtectHostName feature
   * Fix spelling mistake of underlying
   * mckey: Use rdma_create_qp_ex only for loopback prevention
   * pyverbs: Increment the correct rkey in test_qpex
   * providers/irdma: Report correct WC errors
   * providers/irdma: Use s/g array in post send only when its valid
   * providers/irdma: Explicitly set QP modify attributes for reflush
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmNWS+EcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZIOACACuS7vLUAPtQtqD9S76
AbO5yMwcsXanEfd3Shazz52GKCgPScCoafoHUedpX+DQ1sYRsWjLg67VBXSRW2E4
3M6Ywqp7etEfs7aV5FWsZmBCYuXgiJCOgmt27tCCMLesvjomzQe51U5z80AGj6c/
2wy0pyaiYk964AfCBV6BdwQRN2mWL0iM+bXKmHxRt1uiAIXX/Q1awR0IF+R/tU9h
lrENFGzCGGNo1NYZW1owWTCZMU/0vsgz5ZUZay4JsGOg6JbSv8QIcwtCWnW8MBk1
24dyynEeuyKu+ot/nuIXdkRSGQBdFuesfujtl0I2I/BmtXhsAcEsKmgqNAOVh/H3
gTQI
=7WnV
-----END PGP SIGNATURE-----

