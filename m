Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429A0714831
	for <lists+linux-rdma@lfdr.de>; Mon, 29 May 2023 12:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjE2Ksw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 May 2023 06:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjE2Ksv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 May 2023 06:48:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDDFB2
        for <linux-rdma@vger.kernel.org>; Mon, 29 May 2023 03:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFb4DtC7V+bJU6KqtFeCPdcYYSDCTTIPfY8D0rwt69CQHCfgAFBpVoTHQyEily62JKaeBfAVsQmEgyZVjtAkQ20Bje5sNdGxNNM5mFcThJzNFiEtPHyqM1hW256P8K4PxzJGFBCjvmF+W0Wh4CKlZKP/K1yB9pCH+PS9mifTcEMabRab2R3eclduzis/N4GzLMcLNiAuh0mVANXFcAyFNZlZ+dC2af/zUaIBCm5bDc6YDiV3v7ouiPURvUDoIbyGVj4qrEuH/ddgcEtSkbCRnjoLl8dbNBv9D2dzGPgHjIoaebXV3MvtbuZS/r1nfOqN0/iDqsRvoi/egVygjM/vMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD7fDVR/DjSS8Q8StuBu7Sx91OZbIfZ9Ow8sX1+SeIU=;
 b=moVDdsj/DDHBiks/N0l5Jcxg+nUCKlo8V/ITSEkwf1wzzqvritIsxS/EHuBbghjVQQegY/Z0qbUZhOBYg0zDYheXol1uvDS3tVLHAbOHq8xUsjuCqgA2CRbpvR+zzhqlDgWmxECO7kmqioVBPO21TuHVHSil04WPdvHxHjSXWVRL5Lb0GOAgtwg94ZUzcKFTxZIwlYj5nnNQZNXJkEfJG9dSPGUoy1yJ/f7ufG203Iu36TlEh1lW8kBC9Bv0RAfmDsTc90SZi3hgWgB+stpzSE0l33FPG6YRr6+hTczdU1U7cUxI3uLLNRneVeuqzsbskOGOxaeIhD2KchV+/pMzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD7fDVR/DjSS8Q8StuBu7Sx91OZbIfZ9Ow8sX1+SeIU=;
 b=hEHIpGzkEMx3fdVxTRM5Nf63Em/gieDzTBJ8DG6psvSzjQ5mPg68UlHaKAd0/Lc7Co4DQFzmlr0gQf3FYCEq8NBoTXdoo7rbjYXyTyOX6x1y0Jv2yM0hGyNwkKcBZKapWaGmG3NIh7t7rVseuqEZ1Tl7GTW9fJaP9HWHZhZYoGWY+IP5FH/fbItm+aif+N6qtrki/EGRm6LrnzDTa0j8/d2niLR2VkkK7Vcde3y7vrfbkjKJHDKREhoNMex/THeoq/57bqqPShQWv8oktz48vLVFkQ5bg9WhT89YZQir3jVnlpIOnVHbTz3ZCAB4YxTx1xHE6G9TEc1upmSnzWFNuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) by
 MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Mon, 29 May 2023 10:48:47 +0000
Received: from DM4PR12MB6592.namprd12.prod.outlook.com
 ([fe80::4bbc:9ecb:57d4:1c3c]) by DM4PR12MB6592.namprd12.prod.outlook.com
 ([fe80::4bbc:9ecb:57d4:1c3c%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 10:48:47 +0000
Message-ID: <4efc60d6-e281-031c-16ba-ba0f18384513@nvidia.com>
Date:   Mon, 29 May 2023 13:48:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RFC] tests: Fix test_mr_rereg_pd
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, idok@nvidia.com,
        jgg@nvidia.com, linux-rdma@vger.kernel.org
References: <20230525042517.14657-1-rpearsonhpe@gmail.com>
From:   Edward Srouji <edwards@nvidia.com>
In-Reply-To: <20230525042517.14657-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To DM4PR12MB6592.namprd12.prod.outlook.com
 (2603:10b6:8:8a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6592:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: df41d233-9d1b-40ec-cb67-08db60324783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yhfz8YSXMW3eYZjX9gZglzN68X0VNXTH/RyLVdPs5Reb71u3hDwD/hP00TkxBlpHW8w7lr6bdjJNVREOQ3uoomGLUVdFNIcRJ7E4Hp5hkVXlnpYygurJ0sFzQMRKY0wmjyCjKKKfvFAHPVEMmZazZce7bojNEKGB7S2r245G7eP+WncONtuM28qF6CeFlrWBcRfA6qYPyacQ2MiRJg5GYdqDWTSDIjAp+9yA+84JKst9S1q1+ME3V7AB/+Kkr0kuuNhBVkCPIK5tGprdNSpksQYb16S3LhsfQDoMQafEqijqfdMJGwy5ZiqfBo08u8F01To6M3rorKcY8aUQvqZ1jKj39KRx7ow92BeZh/a8QM6BGDnh6Iame38+7JItvaR2R48yBYnaxPvyYDVRWPeprVr6dfZK7UrZZYp4SryWvjjpXoCTshU2zFUcspL9OyNFyQoh8yzOtjs6b8vKXQqj9PFQu8mxevSqiftHGwgbdPP8NnIw1EXw6xrQfIkZHaCpT2i7dbMfjf542l0ii/mameaW5MJi0MKiDpzjfhLB7XmVImMJInwaQvuvQP1wLr4DTwoOyMndw9GpaLcpWWstGWD0tOhZi+TFHjU5xYG07qnB+ZQHQd2axU+sH+AWWtrwknPX5lPCRcgKOLuRHxB4MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(2616005)(53546011)(31686004)(6512007)(26005)(83380400001)(6506007)(186003)(5660300002)(8936002)(8676002)(38100700002)(478600001)(2906002)(6486002)(41300700001)(31696002)(86362001)(6666004)(316002)(66946007)(36756003)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJDVXZydTkwNjcwTmpSREZCRjJoYkJFOWswbmhaMHVWVjlTbGR2MlBKVGE5?=
 =?utf-8?B?VE14QnBkSXFOM3ZiZXVkVGtHVWxGeVNlSUoxSFlNbGdIcjVsTUdKWlVpNkNw?=
 =?utf-8?B?WDBETjdDazZDV1paenhIM2pkT3VBRGZpWHNFTHd2dHpGcHBwMzRKSUZSN244?=
 =?utf-8?B?MkRSQXRsWDlROXhJS3JpQlUyUzd1dXFpY3dXRFJETUhtS3pSVHlvbDVyeFhw?=
 =?utf-8?B?SXEvZlNsNHVJSUV2RjRkVTFOSFBISXJ4YVdURWo0cFF0cUZRWVplUnJuZVVP?=
 =?utf-8?B?VVJSSVhMK1paRjRZMElDb3R6ak8xMUFyY0dsZGZ0WThQRUd6cGxGb045TjF1?=
 =?utf-8?B?cVNMSU9WQm9DVzFIMEJvdGtHT0w4bkw5S3BhemY4UXdPeXdjZTgzNFppR1hJ?=
 =?utf-8?B?RmJzSGZJTW1EeFZiZmxKYmZoRzdodWViaTR2UkpXMUl4Ry9qVkhkdnRXWmZR?=
 =?utf-8?B?YWxBSkFwMDcyT3ZWajJvUkNlNE5CbEw5TlVnOFo4Q2ZPT2hFV1dobmtsMTdu?=
 =?utf-8?B?MXZOc3RTMUJjanZGTWxTTWExSERjUkVYMjNmaWQwT0liYllveVArZGRxRzJE?=
 =?utf-8?B?ZC9CZmVta1pjS2svVUJad2lHUTdjcjlSc2NWYVJjYWVrQ1l4eTNob1cvQzFs?=
 =?utf-8?B?WXZneStFK0s4NUFSQXAzbHFqTHVTM2k0Q3drVis0cmt3Z1l4WkZKdDN5Sm5a?=
 =?utf-8?B?bHFGbmh2UWlROUxBNG4rM0xuZ2JjSndnOVc4MllPSlBDbm9rRGRCQ2xSU0xO?=
 =?utf-8?B?Tkl3djQvNTJHQVFQY1Q0di9PUTBZa2FKMUt2K1Z1UDdGNDdCWWE5Wkd1VGFW?=
 =?utf-8?B?L3dyQUZ5a1loMGlPdE1FTlR2TC9rWUdDVzl4NTF2L1pGeklyRzladStZblQ2?=
 =?utf-8?B?Y1UyeWVBelIwTDlZSzZ2VUlTWHFhUmM5TU8wdDlTaHFHVm1sRHNYWFFJUTNi?=
 =?utf-8?B?WVZGbGFnM2ZvUWhObVYyczlFSTF1czdtdTZGdmE1NXozRnYvM1A5WE0yeGZW?=
 =?utf-8?B?N3dKUlV1VVEzQnlaQ09RVHpldEVHWmt3Snk3TnRIaHdQYlZkOUtxdjV2bkc3?=
 =?utf-8?B?bHV1dzFpd1U4M29kUkpZU0FxamhpN2lEUi92VUh0WmJybk1Vem40Vi8yLzNj?=
 =?utf-8?B?RXVxcDhpZGc1S1oxcHRuclVQL3F1YndDcTRxT1BmUmFrMFVSVnJsZnNLVUln?=
 =?utf-8?B?SVg5VW9PamI1MVJyMW1qeUhNdm56bTdhUngzR3BRN3kzTldObE5FREUrRWY1?=
 =?utf-8?B?b2lBYXUweCtHclJwZ3h3TTh0YUN4bFZmdzZxeGhreHl0K1Bod0diWkRQUUVH?=
 =?utf-8?B?QjB6VEQ4R3FlNTY3Snc3dG5kdHBNKzZDOXFNT2RCZTI3eXRIekFRS0VDdXdR?=
 =?utf-8?B?YndCeENRMncwQVB4VDc5YThIMmFOSWU0WmtndWZzbnI4OHlxeVBDZjh1R3lh?=
 =?utf-8?B?OEhDN1ZIUWlQZnRDa2N0OVZZZ2UxOG5aeWdrc2RLNFdQd3hPQUtXaUdMNFpv?=
 =?utf-8?B?T2gyOEVmMEc4SlJKRkJVOE9idTJNaTZmSnRpQXE0V3g0SEZRRklZVFVnSjBE?=
 =?utf-8?B?eWptWWxPRm50Y2k5QXNiL2R3ZzFCYnU1VVVUWTYvblhBaG5jWTAxYmxuNFlp?=
 =?utf-8?B?K3pDWFZYQTlrZEdPRXk4R29Eb1IrU3FLREdhbzRmMU5HdHZhQkFZdno5aitI?=
 =?utf-8?B?Q2N3UDJldHVIYlRkMTVjQWU2UkV6NDB2VGlseDRYSkpXazd1R1VaaVBtcXk3?=
 =?utf-8?B?TjM1UlRnZjFjbGp6SGVXVEIrUDMybFV1VERZMjR1OUd1N2R5bXVNYTZQVDdx?=
 =?utf-8?B?YWJ6eE51Z1FBRzlpbEtCdXJBRVlQSENHd2NrQm5mSHlRTXVWNUZTZW0vTHV5?=
 =?utf-8?B?RlpPNnNFMDdCRzc1QVBCNEtXSitYcm5IbkxTeElJdHdnRUdMU3k2MHR2MmJ3?=
 =?utf-8?B?b2NQTERQR0x0VVFWQXhOVktNRTJMQmVWL1VZMVdlKzZRcHY4b21sWXoyOWw1?=
 =?utf-8?B?THlJaFhhQm5Ya1lyQnZSNFNOc1NRL2xQcDNOc2JHdUZSRVROTlo0WnhoRUN5?=
 =?utf-8?B?a3B0bnQwcXNFdUFyemlKWXlhQzQrUnBUZ0hXTkQ3QjNoZFpxNUl4cFBRbE1p?=
 =?utf-8?Q?np9blaw1gu819X2j6F5e9yAjv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df41d233-9d1b-40ec-cb67-08db60324783
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6592.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 10:48:47.0921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfOlfLE1chRWxkMJNUwNoUqvaNNdfbXvwUkF9Q359GAFPptgXy/Pyb9ydleU1MemS/MSJ2YQJ2i6WuPXIKlrZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I see that the traffic() function used in this test posts just one 
receive/send WR each iteration.
Meaning that once the first CQE with error occurs, there are no more 
CQEs left to drain.

If that is the case, I'm not sure why you still see stray completions in 
the CQ.

On 5/25/2023 7:25 AM, Bob Pearson wrote:
> External email: Use caution opening links or attachments
>
>
> This patch adds a util method drain_cq which drains out
> the cq associated with a client or server. This is then
> added to the method restate_qps in tests/test_mr.py.
> This allows correct operation when recovering test state
> from an error which may have also left stray completions
> in the cqs before resetting the qps for use.
>
> Fixes: 4bc72d894481 ("tests: Add rereg MR tests")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   tests/test_mr.py |  2 ++
>   tests/utils.py   | 14 ++++++++++++++
>   2 files changed, 16 insertions(+)
>
> diff --git a/tests/test_mr.py b/tests/test_mr.py
> index 534df46a..73dfbff2 100644
> --- a/tests/test_mr.py
> +++ b/tests/test_mr.py
> @@ -109,6 +109,8 @@ class MRTest(RDMATestCase):
>           self.server.qp.to_rts(self.server_qp_attr)
>           self.client.qp.modify(QPAttr(qp_state=e.IBV_QPS_RESET), e.IBV_QP_STATE)
>           self.client.qp.to_rts(self.client_qp_attr)
> +        u.drain_cq(self.client.cq)
> +        u.drain_cq(self.server.cq)
>
>       def test_mr_rereg_access(self):
>           self.create_players(MRRes)
> diff --git a/tests/utils.py b/tests/utils.py
> index a1dfa7d8..f6966b1a 100644
> --- a/tests/utils.py
> +++ b/tests/utils.py
> @@ -672,6 +672,20 @@ def poll_cq_ex(cqex, count=1, data=None, sgid=None):
>       finally:
>           cqex.end_poll()
Keep two blank lines before and after module-level function definition 
(PEP-8 convention)
> +def drain_cq(cq):
> +    """
> +    Drain completions from a CQ.
> +    :param cq: CQ to drain
> +    :return: None
> +    """
> +    channel = cq.comp_channel
> +    while 1:
> +        if channel:
> +            channel.get_cq_event(cq)
> +            cq.req_notify()
> +        nc, tmp_wcs = cq.poll(1)

tmp_wcs is unused. You can do this instead:

nc, _ = cq.poll(1)

> +        if nc == 0:
> +            break
>
>   def validate(received_str, is_server, msg_size):
>       """
> --
> 2.39.2
>
