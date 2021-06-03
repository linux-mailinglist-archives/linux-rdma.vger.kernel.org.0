Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C4A39A3A4
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFCOtp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 10:49:45 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:28680 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230365AbhFCOtp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 10:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622731679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TJBOWIP7moMkMP1T99uKyFw+rUzM1YNzF8B40d31NLk=;
        b=GhoULR95Cvht/osz1dQ/zK+d5Csl38AJmfTt6ryQbKlVDMcAd7nY1R1NN4L8IbYmJyd4zq
        96FxyGkInI+OcMofeAhbVbetUY56UGkzKKFyhSJ80QZ1E4mP4SCSp5KGCQT1+vIrWdFW3J
        XUE/4khLsXD6k9olJOCC5xAnJlIf4P4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-8sOkc_QvOHKF3LgWlLN76A-1; Thu, 03 Jun 2021 16:47:58 +0200
X-MC-Unique: 8sOkc_QvOHKF3LgWlLN76A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQFS0PrgjBOC+rNKL3tv0o23QLjRGiNO+K65KZ1N703fYKBNNDF/2Sh5/PhTFYJlBfyFtTsueBOJXi24XxY17t4aPWl1EkfXdcxVDj+POsPUGHXI0/vUudNIeNCjmBtlTQynhS1ay2f87jeg47524oz/rTTJFwT5vw7aEQ14wcBoqQg2DPGdNiAIHbLkqgy5qSi5bYi5l9PlpCFoFxI6I/UJsTePbeYx6/PsHJMe7SJiUiG7cA968+1qtzm35zyq9+1IJlLe+taRMl87dxbcHXBBKfjBMdH22+Bkkd7ncvfhqFJSZf4SK+tyQMt9oiqBtm4RCSnyNROBhquE4+NG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73D6Ua+fjJlJeR0I9aZPlpQNpJ1M4LchBAS9B+6qj+k=;
 b=VvuRLpcmV7JTpT4E6abbbHkj1vhh0vfHIH2dgexQ8Fg2b61PA6dR0GHt+nt1KTfmZIV5wkBWwFD3Cz50lfMKRarwD/g1DWVKgXjZi7TyXthiMh2umIfVU8FIGf5Wy8juBiwrQhC/0pISa+3srBYSc5yPS6irUovKP+DkUgUsq6UZvYBnDybv1vWkLy5vW43dJ3EPQxmS2kH2omW7BOphwBgqcNbg4pQTY0JnuAswvxcHzlBNCDzOUV9ReB+q4IRtKnxRikGPWX4a2nq6vgDfpIMAAEAQyXK+3uCk4ks+DA6vm3SPjJcyvgBaMCCsDyKJ16z6vXUvhtZTXNkpdY37zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DBBPR04MB6298.eurprd04.prod.outlook.com (2603:10a6:10:cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 3 Jun
 2021 14:47:56 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::59ff:d21c:875e:2a7]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::59ff:d21c:875e:2a7%6]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 14:47:56 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
To:     linux-rdma@vger.kernel.org
Subject: [ANNOUNCE] rdma-core: new stable releases
Message-ID: <046b9cdc-881c-c02f-57ad-f929a5b8803f@suse.com>
Date:   Thu, 3 Jun 2021 16:47:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [90.114.92.205]
X-ClientProxiedBy: AM3PR07CA0078.eurprd07.prod.outlook.com
 (2603:10a6:207:6::12) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (90.114.92.205) by AM3PR07CA0078.eurprd07.prod.outlook.com (2603:10a6:207:6::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Thu, 3 Jun 2021 14:47:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d28f265-5a1d-4fa8-e2e2-08d9269e92e0
X-MS-TrafficTypeDiagnostic: DBBPR04MB6298:
X-Microsoft-Antispam-PRVS: <DBBPR04MB62983B9A491190CF382A1B76BF3C9@DBBPR04MB6298.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msJBhYWseFE1qU7k2TK7zo0S9wenzgyXsKCBr7/buvug0EA3tW+aEOxI9jcLSW8MX8Lut5PnzIWhMnrsajQWlzmQ3BlgwHEpLy7rSl9YiHFIlnG2B9rlI5zN/UGe2gZBRJD2ImivYklh9NnkYPxKBjjkDcU8woDeQbx3qj4QnN4X0BRWzFOMRqwQnstJxgPNU8bp2Z9eGOY2tnh0QWxHFDd0qGN+vhBVRdYG+4XM64ecPRdLkLYf7F3AN2phHstRKEbKfT1dKzfyT0wFVMOyEEyvjIBH2HvSN0miZ7WX+Obo7L/GzQRaAfePwtOcO6X4OTEbySuiQJ80/K+DR/j9ehKnd9+1C5AvNgIOKiTZi4S24cFuvSDhbSFBDZ0o8hRXYfLdoU9jsPpIeYrNT6hafxN64sQ/lk//yssx0cAtpZLnS8ErKsmVNjjMniAv+O+Asaexy3OlNbxnfUdEzwY0Aqczcyr2pb1z0B6nN/W7SnXKNr6zlrlGki+Z890e0nEzNi/12NBdl/1bv35RSylMmhQRsCvocHLc9IOaQ5fHxx0Eefft9TtZF2g62GBVVv4tXUflRSenjN+ahPrYw3t2nmJB/IRH+X4grhLxYhTANCHG7SbEsvtzKAstFUlTryXCuaXvXKtiWZq7/Wxf4wR//mPEPyRv94w0h1mwAJTv5tHWOVIvSM4/4Upu2KEiXLMqrSAZQg4rscF95ed0oFUGzcM92/vJQdmqSe35nrMzAYFv8nXslr/CkQP1bl8eKt1RvVX1iUmKwHLgY8mC+FGEgD5LjEtDYhkZ5bPIjPb5BqbYNdwNoa8QBY++6mAabZq7xFKgHptSF/hXWmjtly8FGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(366004)(39860400002)(6916009)(36756003)(30864003)(31686004)(966005)(2616005)(5660300002)(8936002)(2906002)(186003)(83380400001)(31696002)(86362001)(316002)(16576012)(478600001)(66556008)(16526019)(66476007)(66946007)(6486002)(38100700002)(956004)(26005)(8676002)(43740500002)(45980500001)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hCxPpSurMh9ncQ4uDKGEvwlEJAVFNW9ru9nykOZSRV6ovnrO1fW7JwhzcYqf?=
 =?us-ascii?Q?NKZBI5Xlrtq4RT8AKJ1kIkaLirqv+CKocrNa1+qL21Z2+NNxbewcAtSJmYiK?=
 =?us-ascii?Q?sSuPGFE02SNvsQ/u1OBemF8y78Pb1tP8tN7/O2WaCe+KvHtVSDE1vze3LT5j?=
 =?us-ascii?Q?lQ1EgZFWCTTL36m+f+ojmB9GQyBnHdlhKQej5ejVAUrB1J86zVLMW1DBgkjM?=
 =?us-ascii?Q?cc4b625PVJ6Ets8PQFZmXcW1Azh8eA0qjMktorTN7C+byv3cuQOF/BAd3kUl?=
 =?us-ascii?Q?WUlr3Ue1HKXq+9W3KPHhtX7G/wHtQf3ZcCufp++u5O/rcvyyMU/HeYHjK5Zu?=
 =?us-ascii?Q?NfCkYLwIGk932rjB5C44EU/zfOSUuB4SWDqTQhF3AG0nnrSqIfeTkF0t7AYp?=
 =?us-ascii?Q?MFTzMwEgBypx94mDxCoOJCfbMMV2a7wL6QW4+N+9P5qq5dk+taSsObDnOoB+?=
 =?us-ascii?Q?+9D35E9TWihQhGvZ+dxcS6Qha3Wewxv8J76NgKQmmFVP+dDc5XxyS+o5kxSz?=
 =?us-ascii?Q?U9rKAJZfHt5yioYpc9tZnJJxevLGcJL0jDRS/BVrMe2moyg1JsNRnMEhrgrr?=
 =?us-ascii?Q?QxTm8B5eT8KmYTgmuOYpNz7GTtsPFJMjvLaYl9EpvXXdqks6bPzLmb6d5l3M?=
 =?us-ascii?Q?0Wz5sJlucxypMjMB6cW3dXc3vNcyH/r7zLinUHL291c1VE6MhUcz+bT02nDI?=
 =?us-ascii?Q?BAt9F55KCQ3YpIRfPAipwV9D6fk+bpbxo5BxuvSj34sgduzj5Y8Sm5Zqzwvz?=
 =?us-ascii?Q?blIVngF9vOO1JCJTYkWBsgyQ8QN3a4zs0IWcZkbvEi8DlHY8OH661Wq5fL6d?=
 =?us-ascii?Q?lGMS1Emkwr/GByGPL9mAB2ku82j9ovLCXmEgmKlTkwR7T725ioDKq57rsvL9?=
 =?us-ascii?Q?WCmfzYEjnbah4pVsbqb5j4lpLpTGStdehhU2sU2/EUn4tURuhdIjeagWML4a?=
 =?us-ascii?Q?/9p4i0VjU5R6PmLb8RHfBFaJm/g1shRn0IehL1Q6bk/TVsQLxU0CdJNhCjpI?=
 =?us-ascii?Q?RA7+eyaKq5221436uQrGoD7EGtRbtbLWdeI8F3hhv2Cv+lNKPxOUZgxI+RG4?=
 =?us-ascii?Q?tnNUf9jjpP9heg9A616Rn7rkx8p3w3zA7uR88cd5LFqgtW5vFdNaAbrHJP20?=
 =?us-ascii?Q?B0koXM1gWxqqxChVS5idcHpSkI2m9ujoWZ8l69Nh7S1DGfazMCXlon2Joa8F?=
 =?us-ascii?Q?BNGzX2L1nh7WSqnJpaP9BbI3qL35Lb5nFHXmFPziPVMpa/QIZB3EODWqj7b0?=
 =?us-ascii?Q?d6n+Ykx7rzsUVPvXmeIuIUi+QHHz15j1cvqdHsYFh0ycrEMpiHNKdmCiaab9?=
 =?us-ascii?Q?SA8pAmDRoo0SKCWiY8vJ9jWx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d28f265-5a1d-4fa8-e2e2-08d9269e92e0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 14:47:56.2019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQ1xBeAtkRbGN/Rbscvt/4JMleaxfowxHPneJSajzir8Cv/nRB0yk5KiRmPgebv1D1j2KTBUsAyiLcm1PaSdsV/PDnDpvYqTKaoEOdfZH24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6298
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

*IMPORTANT NOTE*:
This will be the last stable release for v15, v16 and v17 stable branches a=
s they required too much work to be moved from travis-ci.org to azure.

These version were tagged/released:
 * v15.14
 * v16.15
 * v17.11
 * v18.10
 * v19.9
 * v20.9
 * v21.8
 * v22.9
 * v23.7
 * v24.6
 * v25.7
 * v26.5
 * v27.4
 * v28.4
 * v29.3
 * v30.3
 * v31.4
 * v32.2
 * v33.2
 * v34.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v15.14
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:18:38 2021 +0200

rdma-core-15.14:

Updates from version 15.13
 * Backport fixes:
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * travis: authenticate on dockerhub if possible
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4glEcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZI+JCACFTys9ZXM7xK7mtvF2
EUekIy52dWOHaKc/oaev7bzA/enbJr1OdFjvRD7mEMVccoxc9OM2psAXG9wRTf8Z
IV0Yh/1bPYtB0bGeCxnl0WdBzkXeC+LgjZTCLIGbNVSRNx9KW2gNGWqEzmqS905m
v/71/N1M1f6N6Jrxn3mFKIX9eT55Ti4ro/DaOQSsJUTApTs6dKOp4/EAcQnHc/g/
M3+UBXXFzzPvSkg6JHkfsmIWveGJQFevxDw960UzjMXpSH9HGHqxjzQJ/HNdU7K/
Sfsul1TrC2XPOXkDro7107QRaFB6yFZiQbh3fyaOihGKuezY28Hh9HrAA1UFshTt
jRit
=3DFzkg
-----END PGP SIGNATURE-----

tag v16.15
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:18:48 2021 +0200

rdma-core-16.15:

Updates from version 16.14
 * Backport fixes:
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * travis: authenticate on dockerhub if possible
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4glocHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZLxlB/4331qVhlVemDqkimcr
COXRrY9NRP6GGnpya5Dx23PhaHkrUpgd1qlPeTpUVT957toCDhWcxliMaPCFTNY6
K9ploZ5Lisr5O4qUbo7CWxjURd5BAz8tIv5TW336HFFyOeT2VJgT9zvt3RNMeJD5
Ml4zTSvDrUqinPgwt/UWlbKqlYzOlBuqzBCRH49f/ub+WctRJwTxsQRQL1QMJgW3
CV6NtcoLeBaOBjfgI5EayZxShE5lgo/6nFsbVBe4fh8NVw556te4zWpa8sJ19/Jy
aZU4EnZY66IYs8mliFhVSw5aveFsYcQXcPo8fbKGpSVeKxLFaf6YtL4U6KKMs6em
Be30
=3DDNyh
-----END PGP SIGNATURE-----

tag v17.11
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:18:53 2021 +0200

rdma-core-17.11:

Updates from version 17.10
 * Backport fixes:
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * travis: authenticate on dockerhub if possible
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gl8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZK2fCACZE0O+m27JCD/9HBxk
LsEZZSgwbUXNLHMm3dXR/oeM/S+DiuKt7dZ8iIU/ktM+vrSsVfaeA0Rqeb2Jyc37
OQo5duLpirIiqMRBWTlHYr17Bdri252AFfaHPavokN+XkCOnG9duqCxLKuDl/PK/
Ms6cMIWnrv2YkFDp5y9iySzHz2yFf5VRgNmRpYeusuEuoZk5nXJziB+jQs2Q8RzO
S/hjEy2tpQIXEG+E3YlZ6Ji2Q1laDA5bmegAakQxXwUFHSmIPfmzyKztqGVlKGx3
t7x6HqyQGzOGi/SlJzvVDZiNqiRLYhj8Zy3kSPmGPCux3BxnKYglUYkZzwGEPnl6
ABsz
=3D/NaR
-----END PGP SIGNATURE-----

tag v18.10
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:18:58 2021 +0200

rdma-core-18.10:

Updates from version 18.9
 * Backport fixes:
   * switch CI to AZP
   * srp_daemon: Reorganize ib_mad_notice_attr
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * travis: authenticate on dockerhub if possible
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gmQcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZKDTB/sGTkBN8NiOkpvLO/sL
ShrIStdf9tw4UU+u2lnnlvHrDfBNnlxaTW2N6v5sWWXrTvX1jdSuaDqsAgXRoHPR
88g5yBg+YkzHXFsAa8V6dtKg5tNrCv2BITx8uQHzyVu1J0ALyWa/9y+h3+pPAOXJ
z2pJkXJav3/m9JRgcgF8ZiLxMh/LNwoyrGbbF7vI7vMjJ/VdjEBytgcm2KMX5z30
34WfWP2ScbWCOICn9WVBE6pe9/CEz6kH+7m0Eg+E1CDD7Pf/bCiKxLXNyD7PvQGa
odeXVJzigiUSw8Q9LrNrNhL0ZJQPcPNJRjMS4V3FPfhf6RIYLImwnZpxPVf3JIYD
nj+D
=3Db5E8
-----END PGP SIGNATURE-----

tag v19.9
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:02 2021 +0200

rdma-core-19.9:

Updates from version 19.8
 * Backport fixes:
   * switch CI to AZP
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * travis: authenticate on dockerhub if possible
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gmgcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZF/CCACW1h+cXS0NGjBB7069
Uri89PXHaFh1mbcqCRMK/UslYUVyac7RRRaXK9ZkJHpNRQllLQF7v+GACMbKPKxR
kcgpfnoQ3X8xYPbw6jM0u3OO+FGMN0r1NXVsdI3qn8PCOqzLKpXsMPBqiZkqLqDf
bPZVreCf0yaxqPkGL8I5xE6mz5wMZoNnfJ70c9NLoiOZa5xaGchGu2c4Pr9v55Qc
hRm9n5h75GixPdmIBPWqhywGHb5klXSR6fzdP65EByRn+8DehO2fwrN1WwdPENVc
ylnhYYLeGRy72ueAqmrEAldaWYJ2KCz932NqeIj/wHZud94CYCf46rjbNE5vQd2u
UWso
=3DQy67
-----END PGP SIGNATURE-----

tag v20.9
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:07 2021 +0200

rdma-core-20.9:

Updates from version 20.8
 * Backport fixes:
   * switch CI to AZP
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * travis: authenticate on dockerhub if possible
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gm0cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZIVBCACQOFCf2bGLfklv6XPa
vEbkznsheYOYyQIgzwCzUkLCgMZ0isOj6SFsnx9257spUyphX5YhG4I1rBPME7Aq
T+Kc2WAW0le3jWL8xjRAlfyFPGFVRYcQuH9JVbQUJUa1/v+JdC0/uvOiZnlHx3Wj
eg1oYQiI37bqMU8RlU38LwYrSZSQVDZLSU2vUSN18mEuTi1Gy1eWWhbSeDMUDtcm
BSMVAvCm5ybZ51aXBSBf7xWjDAo8djlUqj89pKqozfAMzPix1oxZXOR+LW0POsv/
UgMx/7IB2sRFxNCIjzv880sCi7fkVcCWIvwNDqNdbn53W8kCGnw9gJg7/RB4mHQm
O4IN
=3Doo5m
-----END PGP SIGNATURE-----

tag v21.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:12 2021 +0200

rdma-core-21.8:

Updates from version 21.7
 * Backport fixes:
   * switch CI to AZP
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * travis: authenticate on dockerhub if possible
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gnEcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZOHiCACrQiPrKmRUbnX9gnxj
YXFRDqlIhtBZ3dR7lmEkpKUW+5G9XsXNT1c+TG+w6KOw6J0DMK2Mi28PHfMemGcE
yKZLzRcMuwZnnYXD4yOETCcjFtIwfU5DdK+Cd8v9VFNgmPMOW9ZJpxpcWHExCpuy
T6dTgmM09lnxfBOwLPJ1umpZVzLZxTVv33j+uVobRYPwO1/P1kD4ateXKYftdq+T
JDUvIY8HO8+QtxWw1TxvwQVYwtphp41qZvokFpb7qjvPcoGlyQSofZ2eKoCuvSkU
QnkdjYkPoWuPyX6GbPxhtEmq9ADpIbqH8Au7Z9/9DYbK/BtW5TkzqhR4sXh1DX5s
EuuK
=3DId9k
-----END PGP SIGNATURE-----

tag v22.9
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:16 2021 +0200

rdma-core-22.9:

Updates from version 22.8
 * Backport fixes:
   * switch CI to AZP
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * travis: authenticate on dockerhub if possible
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gnYcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZMB2CAC3UUWQAwKU0HPB97hn
jFy3uZfLNlefk1jHce+igjnnaTkwlNHGl/Olerejj9JFmdtCbmWCFDq/7Vz7siuL
9cGTA8DGoMTeCmBorLyeP8HmWtHx4YmayrRMCSlrMXYggZsacF7CKBICsyoY6t8w
0LcO7NZOMDpaAQUIK+DCZWDnzcqiAGiKrOFsCpoWvhDImezVdMLC1O3gd0YYoWxh
JUIJuo7PeEODih+Mp7lxZ0kxFYQ6xqBK4kLc6pTLRtxAh2FEsIYoR4F05bfZl28S
gHgsiwFe1DTocJdGcWwm3AoHoLjnvL4KLrWF2V0vQxtYYiYqXVSNi/ICw0DyYV1f
zXDU
=3DGm70
-----END PGP SIGNATURE-----

tag v23.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:20 2021 +0200

rdma-core-23.7:

Updates from version 23.6
 * Backport fixes:
   * switch CI to AZP
   * ibacm: Fix format string warning on 32 bit compile
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * travis: authenticate on dockerhub if possible
-----BEGIN PGP SIGNATURE-----

iQFPBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gnocHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZFLiB/ijW4NjnOpJ39JLCEoO
AiARiEFBsF+lWuiBLP7yth8G8VQlmJDU0SKfPY04BrTmc0CVflTtTtn0BO7yIKbh
5VB4TPk8MlU0V4QGU4b4/6SkB76CJTTCgZWq5Ingo/n3OLabBV8nRzJ94/JdqYiM
6w8sysrMCb5ohVSQpqhQhKcBjNB5w0pqLUXmUn4rrJlfTYs/b2ZhLQjIBtVt/G8w
jpE8DgOFl0UU5JOtTIn2u9XkAnqmeLngLaTLLWQFWSaJmgr4TN9cUu/lGJrX/+lP
QFgVDYA8TZ8IrcTmsaQwbCVf7p7OWcPuh3cTcVx3clRHsFLof9Kt3HigQt2hfEd0
KuU=3D
=3D+ADp
-----END PGP SIGNATURE-----

tag v24.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:25 2021 +0200

rdma-core-24.6:

Updates from version 24.5
 * Backport fixes:
   * switch CI to AZP
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * mlx5: DR, Force QP drain on table creation
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * travis: authenticate on dockerhub if possible
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gn8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZMGjCACRo385BaowiMTYNi1V
I6kgFFd/g+rPkDCncyvlbGh+jK09ip4Szqh4eF3q9y0isjpAP+otD/2ScWeIl7jQ
4mBDBNcFtUSZIl6p9dJ8YMcJsfzqqMe4RLfacMQcMqPJ1utBwVbpsAzmPBNd1tr+
OiKVZfrzEF7862fpOPJPIPUZAAs+pUsE0XI7s5+wpD7CvTzKOL3wXWfgRa6ve6bL
muDfSBQL+LXoU0qoe8RtNtbdqYgt0qKVJ2VD6yu+2WPAVg9FGLnO/2chlgi8P+x5
+Dp517m9nMUXtyikCX9hraUmQXoayLXdQIy1b33Cgv7GdpNgB+IVmhhZ7cUttu/R
WAcC
=3Df28b
-----END PGP SIGNATURE-----

tag v25.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:30 2021 +0200

rdma-core-25.7:

Updates from version 25.6
 * Backport fixes:
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * infiniband-diags: Reorder library build order
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * mlx5: DR, Force QP drain on table creation
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4goMcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZIjZCADD1WYTgtN04ZYw2aMO
zrxWO0nnvh2P2hs7ADQNnFt84piIi2TQenVZSjJRCsQCs42GZInl6jw57GZnao+8
6lZEqjgVb3Ywq3o8uAwHoQP1NSSUd726jTADIq/jNreKVFKQsbFTlqD/J9qmqDV6
j1N2WFVbT9AbY71hNzHq9s3OxaWcAcPhAFHPtrVi3cx9zpRjXb3+hGre/dvGhJ9y
CJMflPNP6nrpjRfSnrE0YRw8vXU8peM0M1frTOJtzNXmob/tSvv2pvhyloC22qTF
8GzCoWhgC7dcX9Z2OQMjBNbDAOdq2vg/J3uhg+WjqPZiLkEowkFM7VMLn/y18yMx
cPxC
=3Di371
-----END PGP SIGNATURE-----

tag v26.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:34 2021 +0200

rdma-core-26.5:

Updates from version 26.4
 * Backport fixes:
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * infiniband-diags: Reorder library build order
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * mlx5: DR, Force QP drain on table creation
   * kernel-boot: Fix VF lookup
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gogcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZPgACAC4Goq5lusDXUadg/zQ
dGMJLVYhlmLFyQYKuoo8Lku7n/TXGF9OdTlg8V/bW3rNuF0az3iiIWGP2+zbjSUc
TuxdBEW+kTzqKJX8BC+yiu79ki/zv9uBZG/y+VWnnaZpx4mTZhXv9MVMZGXEPNUj
DqBmBXDGJYGyHimReeRIDmb1QkJgjT89As2earD1RDuSyEDU63fCqxEoRs6Go3ii
v/viEXAYucCGrjUI4eDRBgVsTrbDujsxqE4vGWj3bm35M/JpCwib1w71pcyTbHDt
ZS49Z5kW8ExeOULbgecsxdPNy77JLmiH9t6RPQiFYkvlmLP0bz/P0u20AdgXeaJE
Acwh
=3DvPbY
-----END PGP SIGNATURE-----

tag v27.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:39 2021 +0200

rdma-core-27.4:

Updates from version 27.3
 * Backport fixes:
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * infiniband-diags: Reorder library build order
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * mlx5: DR, Force QP drain on table creation
   * kernel-boot: Fix VF lookup
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gowcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZDbhCACcVIc6JEmf2nM9S5FL
RexpxkwLhu8cdVJDcJk5pGsmGGNDm3VuYYkXNBSBpoCK+6eJFgWGIHMhakeGRg5b
CZ9MxX6vuWNTJp5R1HkcM83tBQ5GBtGQejYFx4zJ5wTgDlK+lrQP+1mTjT5lIkHM
BG/xko9T13S/pF4yMOcv60909EcYSnaA8ck75cSPfUkm6XwLTfS/y7bYVd6tR2By
B7h8VVSb6mq2CFoAhwOC/CIF5rDAIL58w6/stzQZ3on8jc/ZlWl/jIxhOG4Zif21
EtlK5fq46VEdQa6f9yyvM7gUvEu1fLG4Vtta5vUq2ILLZYh7ClObJoXjH5JaQ2hi
4ooc
=3DWVyO
-----END PGP SIGNATURE-----

tag v28.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:43 2021 +0200

rdma-core-28.4:

Updates from version 28.3
 * Backport fixes:
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * infiniband-diags: Reorder library build order
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * mlx5: DR, Force QP drain on table creation
   * kernel-boot: Fix VF lookup
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * efa: Fix DV extension clear check
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gpEcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZF9ZB/9IY3s1VeX3H9D4xHPF
b5DFy0ICuWAkmid1C9hc65CVlI1MkckTaVDUqjtZqXcWJTsdzmTdpzP7r1BenZin
iTmJHSadmFXNcKd/Et5pJEIIsrLMySEWYzdXtybPOePEZ/UDVbi6lorLAxH6MraY
XjYwazzThmVwEFldmY1OaWRsJRD7NOQNmdBstH6rZImD2FVVxA874+b5jqyRZkqg
FNSVuVdgjnqKg8uRzCugvl6nGGat2lDRcqOPYONLZBlpuT5+Qh5eb5GX2lnZ4Xc7
mkZ8Sxl1oT2oL/bvtJVdoeoFBOWXi637j8R7tnJxVUFEppQge9Eg0dxZEKx48NF7
69cj
=3DkHt8
-----END PGP SIGNATURE-----

tag v29.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:48 2021 +0200

rdma-core-29.3:

Updates from version 29.2
 * Backport fixes:
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * infiniband-diags: Reorder library build order
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * verbs: Fix create CQ comp_mask check
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * mlx5: DR, Force QP drain on table creation
   * kernel-boot: Fix VF lookup
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * efa: Fix DV extension clear check
   * mlx5: Fix uuars to have the 'uar_mmap_offset' data
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gpUcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZFroCACLL1ts/Y8PGaw5dZ7L
i/Fp9+ZUo86ajA3octSQWRlo/P9Ggt/WFNV7sD2hAt5E3zXeLkh5RhIGd9v2fejc
601l1elsOtOpb9LVcmlXG/R9LcBWFlsPGV9om3RUEJY3MBJ5mZdHxzkWSQGrHfeM
0u4jeY1E+/b+hYHvSNnlEGCkRe8kin1eeEfU2kraZp9G2tCjypE03jSDMZ2lCKql
doZvPPz3CYIMWciz9Q1quJxHjwS6jeM+i6HZ91Q+tCROmC65cyhHdVaYA/JzlMb8
RMiqrzpCZwgjJ2LN28dbeHTNoO2uZ7j0knMg2R3CQRBF1ZeYKg1q3OAERWhePIsZ
rhSz
=3DASpf
-----END PGP SIGNATURE-----

tag v30.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:52 2021 +0200

rdma-core-30.3:

Updates from version 30.2
 * Backport fixes:
   * libhns: Bugfix for calculation of extended sge
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * infiniband-diags: Reorder library build order
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * libhns: Fix wrong range of a mask
   * verbs: Fix create CQ comp_mask check
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * libhns: Remove the unnecessary mask on QPN of CQE
   * libhns: Remove assert to check whether a pointer is NULL
   * libhns: Correct definition of DB_BYTE_4_TAG_M
   * libhns: Avoid double release of a pointer
   * util: Add GENMASK helper
   * mlx5: DR, Force QP drain on table creation
   * kernel-boot: Fix VF lookup
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * efa: Fix DV extension clear check
   * tests: Manage exceptions in rdmacm processes
   * mlx5: Fix uuars to have the 'uar_mmap_offset' data
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gpocHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZPg1CACvgqqOLyT7hhbFeAtH
vMJ0f2CsA7/1aTOx5k/+FrYyENef4+712zHua/jLlqPAoYfacXvi4NpVbaARbMm1
NYPuEytFJqae6nevybc857vIe972hxvqzhReyhCDCe9ZN7HnwTz8cTuzXExPnfBf
wln2bFcoK03Ra3SBxxg8E4mGNotOPhPv/VhUQ9L2/L0jJcP/aA3rylECdLa4/byc
hVugNCGFObrQtMD91rvE0AZQHoKxv9KqBOR3Gqb/UFJvZHkeOg8txmGEzE3uGqAv
StXhK8plMTi6azCDdbxqA8DKp8tYZ41KzvqSleqGIoH+bE2KqBdAevjFhA+di1x+
VNWw
=3D0K7U
-----END PGP SIGNATURE-----

tag v31.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:19:57 2021 +0200

rdma-core-31.4:

Updates from version 31.3
 * Backport fixes:
   * libhns: Bugfix for calculation of extended sge
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * infiniband-diags: Reorder library build order
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * libhns: Fix wrong range of a mask
   * verbs: Fix create CQ comp_mask check
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * libhns: Remove the unnecessary mask on QPN of CQE
   * libhns: Remove assert to check whether a pointer is NULL
   * libhns: Correct definition of DB_BYTE_4_TAG_M
   * libhns: Avoid double release of a pointer
   * util: Add GENMASK helper
   * mlx5: DR, Force QP drain on table creation
   * kernel-boot: Fix VF lookup
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * efa: Fix DV extension clear check
   * tests: Manage exceptions in rdmacm processes
   * mlx5: Fix uuars to have the 'uar_mmap_offset' data
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gp8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBRXB/4o6s2Er9Dy44/Uudad
hMDRxu35ROczEdCeRWAaMw3gPgVe85uuVMjizM6R+zj4D0FpG8gVFPi5JJXKUoxp
4vVIuSRG4RosvoJg5ISa3D3ihKevDoVN8AaLphDQUvlzJQ+zyReFv7MydHDe6aaW
EKUJzY7gLD/+eSW6qA1u+9tUN/JdIQBB/TU693dfUSqzvpvnFrgcClmmpsk7/otK
HXGXVjSGmFtOWPG8OM2KcTm2DM4TrJohQ7b4ZkNhoZyUU7RNA7ubRZCzL9Mi+pY1
pHg3XO0ohNNybMcAZYZcTOfmxj5XGD67RI/BDHOSPXN6ydJ8SO5mwhM6LPOqR87T
ZhX/
=3D1icV
-----END PGP SIGNATURE-----

tag v32.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:20:02 2021 +0200

rdma-core-32.2:

Updates from version 32.1
 * Backport fixes:
   * libhns: Bugfix for calculation of extended sge
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * infiniband-diags: Reorder library build order
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * redhat: Do not add rdma-ndd to initramfs
   * libhns: Fix wrong range of a mask
   * verbs: Fix create CQ comp_mask check
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * libhns: Remove the unnecessary mask on QPN of CQE
   * libhns: Remove assert to check whether a pointer is NULL
   * libhns: Correct definition of DB_BYTE_4_TAG_M
   * libhns: Avoid double release of a pointer
   * util: Add GENMASK helper
   * mlx5: DR, Force QP drain on table creation
   * kernel-boot: Fix VF lookup
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * efa: Fix DV extension clear check
   * tests: Manage exceptions in rdmacm processes
   * pyverbs: Fix Mlx5 QP constructor
   * mlx5: Fix uuars to have the 'uar_mmap_offset' data
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gqMcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZFv8B/93O2NYswetvSGmsZ7n
4lPnw4HO2xyP1y1pfVB9HHc7le2ednFo+O5r2NegQMWS/UJdCg/9yHHtudD9jbrg
An5DIrr4F+Z5TjQV7dNo6sj0kdESn6e8h9XfOihNyizIyFCG75ac+rsXsjkmEp5Y
b7/AlRJB4Kku5zFYkGmB6uoHssypF1yvGc54c+qK7lpA9j9UG1tOmi1OHxQhA2Df
6TpR92ZWHNB3WiThF/KN1emV+kjWYtGl2ooaWKX0CLZc7DTA9VJ3surnzdrzvq8x
I2r+Vbdsmci2/8XZ47FiW4FBASntKRO3zj9qC3Dx1yDiyWeqUzoLxamnIIQXH2+E
SFIg
=3Dc5iu
-----END PGP SIGNATURE-----

tag v33.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:20:06 2021 +0200

rdma-core-33.2:

Updates from version 33.1
 * Backport fixes:
   * libhns: Bugfix for calculation of extended sge
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * infiniband-diags: Reorder library build order
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * efa: Fix use of uninitialized query device response
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * redhat: Do not add rdma-ndd to initramfs
   * libhns: Fix wrong range of a mask
   * tests: Fix CQ creation in parent domain test
   * verbs: Fix create CQ comp_mask check
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * libhns: Remove unnecessary barrier when poll cq
   * libhns: Remove unnecessary mask of ownerbit
   * libhns: Remove the unnecessary mask on QPN of CQE
   * libhns: Remove assert to check whether a pointer is NULL
   * libhns: Correct definition of DB_BYTE_4_TAG_M
   * libhns: Avoid double release of a pointer
   * mlx5: DR, Force QP drain on table creation
   * kernel-boot: Fix VF lookup
   * mlx5: DR, Check new cap for isolated VL TC QP
   * suse: trigger udev rules after installing rdma-ndd
   * ibacm: Fix possible port loop overflow
   * verbs: Fix possible port loop overflow
   * efa: Fix DV extension clear check
   * tests: Manage exceptions in rdmacm processes
   * pyverbs: Fix Mlx5 QP constructor
   * mlx5: Fix uuars to have the 'uar_mmap_offset' data
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gqgcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZMZ8CACCs0XVWUwa6Q4zjKrg
aC8Ml4uRAWhowtxEiFbt4jyfv/L+xKnR9FZO+zFohbloZRc/hWiKJMZXZPOviERu
G1HQqy9C1N8wI4EWF1DBH1kOeeXieZ6NoJEqW3/1OLrbQqajYJOZQmroHVbVRiol
jIhCw1EWVbEb7o9zrV0Ybxh4Ttqk79HgiN6jEgGJgz7+dMGFW0f6tLVGZyYxi8wt
P8CtpymG36YFa0KYkuoQbhCIlKAPPwdLLL5hHKY9U451j0qlTPpAU52V/yo4sC6V
GZMEiVSXKbBW3txWCrv7epolrHgtsFmzFRXWgNwvkmynmZcdib/PPMT7sDU4V2Sk
3Eyb
=3DzqeV
-----END PGP SIGNATURE-----

tag v34.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Jun 3 09:20:11 2021 +0200

rdma-core-34.1:

Updates from version 34.0
 * Backport fixes:
   * libhns: Bugfix for calculation of extended sge
   * iwpmd: Check returned value of parse_iwpm_msg
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * suse: Fix path to dracut dir
   * infiniband-diags: Reorder library build order
   * libhns: Avoid accessing NULL pointer when locking/unlocking CQ
   * buildlib: Continue build on old GCC versions without SSE
   * efa: Fix use of uninitialized query device response
   * mlx4: Fix mlx4_read_clock returned errno value
   * verbs: Fix attr_optional() when 'IOCTL_MODE=3Dwrite' is used
   * redhat: Do not add rdma-ndd to initramfs
   * libhns: Fix wrong range of a mask
   * tests: Fix CQ creation in parent domain test
   * verbs: Fix create CQ comp_mask check
   * rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
   * libhns: Remove unnecessary barrier when poll cq
   * libhns: Remove unnecessary mask of ownerbit
   * libhns: Remove the unnecessary mask on QPN of CQE
   * libhns: Remove assert to check whether a pointer is NULL
   * libhns: Correct definition of DB_BYTE_4_TAG_M
   * libhns: Avoid double release of a pointer
   * mlx5: DR, Force QP drain on table creation
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmC4gq0cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZESGB/4xckRGIMcOuf3TWp2o
NHU27ccQI++s6Pw5uP9DLdbX5kUV2hEYzMzwnwP7eZDiV6xUAuvNDXlHPIDfgj1b
znXbqrH6NHVfeIyx1SWe3e23LxinAwPcSRt5pMtT75+UDSMiatVc64Mrzzo66xvV
J2ms9bzi3Tpx9frzX5K9C1/PDmwvlLyDMXubIp/kTlXJoDEtePEg60l9FtcOy1lq
dKFU+NJ8FslVUgDLhVxGBMf21I95lQDvjA5JEeZpvm6PUp0Pdi8U27fYqyboI2dh
/mkZkJQmpn84/Vh0gJU8nJUvBUm7foZ2BOoCseCkG2VbNr07Z+/qkYJNjN9hcYMs
tpcC
=3DIfMV
-----END PGP SIGNATURE-----

