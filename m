Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854D97A97B0
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Sep 2023 19:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjIUR1F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Sep 2023 13:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjIUR0q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Sep 2023 13:26:46 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2067.outbound.protection.outlook.com [40.107.105.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998BB30C3
        for <linux-rdma@vger.kernel.org>; Thu, 21 Sep 2023 10:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsEycgqNFPkKFA140gHldApjkn83prZOiRiUNLXQ8rxtd75QLnMzhjY7vtv5WmvJzhKFSY2B+0McBnd46OuHsjD8cm0qeckcO5k9K8O9ES1G+g6d9wy2W401BabUHXNyIDgxPkxzFDHv5XohddKVGrc3e4zHe7ieyjvmzb+Kd/NroGeuWpj3Ozl6zCkOwIukDnvMzp6/z6374lI6IgYOeCCT2efiybZqLiAHZSOu+Ph78DSSfPtJllOLS1r95hNWxifE601+7fFkQMTd4nEMr/yLqaXwxo265jxnIFXtfb9mlgrGH9HaG713LvUsYctl1UQZIPKG2IJuqXZFPV4j+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s24u71FwJZ5IRnpkF7iw4fXDnE76F41TGzCmgggPTw=;
 b=BM8NO8Hp494oyr8biJZylLhQDn6RgXaoPDIqnj46VDyzEbu1jzlCOKO9/rOegCXqwAWMnW8JmxUSY26YNMZtDtyPRPflEs8FmPmzxmtpeJyDjStIK9Pzd7+IiCk0aMmuzg5+4kL4qV1pBhB1sOElSRqYhKBSy0oi+ahB0x9hZpn2o0Qjag9U8VtXFFNEybLrIBlIVekLcn/6DK3pOt7vZnr689iheJzaltc2iQVVKBeMHDQPoYG0UXyTb4aJcLZAuGNxhFSfY4RwWa3e4i6enJoNyjRRePdQJWOjhtJqv+CjAtdVMHANCNxviM9epDxF2m2X9PfAadgubgqxE0LagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s24u71FwJZ5IRnpkF7iw4fXDnE76F41TGzCmgggPTw=;
 b=Fv9TZYI5KY9de2HwuAPW8gWv8/SYq4K0VvrZ8NCWPX8X7v2uqLP9QQlSGA2rAFBnPRituQq6laSXP5pulhPYyxUGb2naPKJUpFoVhhtlxG40denmv1mrbt73psWh8T174ZsJONUhK4c0ysikNy0TMvHdM5juilutJ9f0U7Eij1vG07azn2wJIq9lJfHvxPJybK2N+VCuVDe+0nV6GrWw1lj8HCEIE8SIoWUIkGZS2kh1fctBtRTHn1xy7cznAH6aXS3+kmlbtt8A1zZfFV1f9SPJx9oVTa3mQZQ1a8Qr4FtIuCaWN7sAxRljx3Y8U2ashe/GKN0o0xBGPUYi1jzDfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com (2603:10a6:7:1c::23) by
 PAXPR04MB9677.eurprd04.prod.outlook.com (2603:10a6:102:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Thu, 21 Sep
 2023 13:55:25 +0000
Received: from HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::fef6:bde:8f08:e85b]) by HE1PR04MB2969.eurprd04.prod.outlook.com
 ([fe80::fef6:bde:8f08:e85b%5]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 13:55:24 +0000
Message-ID: <4410ebe0-c4cb-98ce-e493-0c6cd9a57b74@suse.com>
Date:   Thu, 21 Sep 2023 15:55:13 +0200
User-Agent: Mozilla Thunderbird
From:   Nicolas Morey <nmorey@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases
To:     linux-rdma@vger.kernel.org
Content-Language: en-US
Autocrypt: addr=nmorey@suse.com; keydata=
 xsBNBFjZETwBCADEkoe7QWAXzd9xpSiPbQK6P2F4wKdxyTp6r0aN4I0O+4fc8xWXvmwOrCjF
 UsuoGZ3CxJaHgdB/3ueW/IhMO5Ldz7pylhKVlG/moUh4CBK2eRUdaG7mHID01GyJMtR3VQqu
 22hJhHPYy0erpYViyr+I4MzQA9QZLoQhSxn4imjZOZPcj20JE+lRfXppNv9g7vQiRLMcXjTi
 KcnrqG5owOi6Cn1sZ201YfdeztGxKA+jvjWO+6absTTlorIlZNGUf85s2+caGDsqa31u2DPs
 hVv5UUTy1g/5aP2wacSWI3Qm4n2MWl1aCnHN2h737PCXXfBk5iGJsgBUnSQULgdgEAt1ABEB
 AAHNH05pY29sYXMgTW9yZXkgPG5tb3JleUBzdXNlLmNvbT7CwI4EEwEIADgWIQRC0lOFwaHA
 K4sbHG+AG924JZiPZAUCY5G8SAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCAG924
 JZiPZMZiB/9QkcGfH248qvFUWZig3jssK5IgijfOFDKB0YK4e844M5C8LVSuWpu7Z+lM+cql
 3mbrikW6mlZjPEusrQ/KGvT6TdfOM9VCQWjlshMzt7uiRDdzufHGtE5hhk/67UnkEVjmplpD
 k8cb1O0VsBfGym7e0nySHTlDWqr++9EcwgV3uo4psYYEqm6Aon1yKqjbmj+vfl/C5iW3V4lq
 DhBk8w21AvNS+tdEqJzhruxuXkEDZZ07wYFS7m8OxLNb4sMzn/Nz9x/NXeweBWx2ujIERtAq
 1e/hh0ZAcoPVR3CfO2QTmfTfrzVdpZrZ8F54337ze3+BUNnrFGObQhlNe26NqNYWzsBNBFjZ
 ETwBCAC9zAzCRlTgzyO9siVLQYwbRUhcL1TUJU/FiOQWQTmL3uDdBc6MgVBs+hp82RwPbbXT
 v4W4rghBYPKdmFXvRN+jvGDLq1f2hsuCSiE1ckTMzFV+sKoWRIEC12tEpw5ncEFGm+1k/rJR
 Lk9eHxuqn+yRjPryN8CK6tK4+b4tZ2urKlP29XG+T3l/mbUSoqfjqvyeKaW6xw7ku89EX2Xo
 QWP/pm92RxUd6VDU9vpVW/T7qPZRl0wtUnDnO2wePoZmvUfEr5Osh3MNvm1myG+v4EV2Hgva
 NT6pa27IptrUq06cA6dDsIKwPtMuThJQp8/xumgl5Q9A/ErQoJTrB9rclIm7ABEBAAHCwF8E
 GAECAAkFAljZETwCGwwACgkQgBvduCWYj2QwNwf/eOIpFB67cKoUJvcm3JWcvnagZOuyasCw
 xwH9a0o9jORcq+nsJoynS/DpjUKGyZagy7+F7sBrF7Xx0cXF2f5Bo42XNNiQDE5P/VLwvgn9
 62AJ3q0dp4O7oQI8UgNmdsocQhNaBHHCoOabLGrgNobDTaLBeb9zaOZqz8CBuAiZ0bVABEpg
 50hDEYTHp4jCgWpadhAsp/eCgm93Tc+Y+e1fqtE3FmoOLxyhFa6evhn0Q1iX0kCasMZwlzse
 zqLZjTM1Koqn6+UIHXE3QaULyFKD1GDhisXxyolOB6P2TXsyfvitYdIZ3CCtI7PVDxzmX2Xk
 kvEz9bMtStoMpse9qAsmHQ==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0181.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::12) To HE1PR04MB2969.eurprd04.prod.outlook.com
 (2603:10a6:7:1c::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR04MB2969:EE_|PAXPR04MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5ca277-f9d6-477c-f1d6-08dbbaaa6745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jX6NdUTPRerg4sZnL7wJ+GjwloL/ILkYqdROBreqQPQg7AIX/kZFnQ8XOMN9kAczhw6USGlk2Y1o6Az2bHN3z9ThxFgDMZ3kV7qaacmz4Hn4YQxsr/WPKVG2ddVEVv7ZbRIRTsLoFfRCVWxus+UvCBL+FJfdOuQMsCCdJsVHLc5hRvLUyjR3nND2QI5dUy+ScJW8Bo2B0ZawH44cMzvKq7H4T7DNPBJza8fMhtVdrOArYUZLiriEmJAfKGR5Bf1yc37hjtJ2bnPKrskip58WsS8KQXoKfLtiTtzcfVq6ZazvnEo5W36XwDxHknU6UC0O5gCnQB4YPTADOzrwCp2NHiX4/KijJA/W0rdJsuNNgoztIky4P22Wr6FQZgjqKyawcD2sNVd2FbB0/A62cskvGH+DbSC3j04yGCuKtIYUYMiPQwKjRVF9/WncWH6BGCQQWwImgeyU09zhtIejklWIYSWPnZn9WNKeca+7BLx4RCVC3QdjXYrNc91RjR8Xw/zjJRKfkZFJEI2KdWPSQjXVTd4noXmOAFUBS7wmpvuIDRlV5PBzL14Bn05C9TvDAZi/bGe9Yp0I+9rkSUbiN1bd6DN559qBhi4xh2uWtKcwfJ1vXZ1TxCH328qa/fBTAdcFWTC6bTm5Z+uWydv+Fpeag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB2969.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(1800799009)(186009)(451199024)(2616005)(26005)(8936002)(8676002)(83380400001)(31696002)(2906002)(36756003)(30864003)(5660300002)(6506007)(31686004)(6486002)(966005)(6666004)(316002)(6916009)(478600001)(6512007)(38100700002)(66476007)(41300700001)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODZLdXN2TXV4Yk5nY0xMTys3L0tsRUJRY1ZZaXhkSWdJUU1nZ2FFYkR1ZFAz?=
 =?utf-8?B?b3dJQkhmbU5pZm0rdXpjbVNiTzVnK2lGa2w5TWRBQ2tvdm5rM0E4NTczRG9R?=
 =?utf-8?B?V3VORDJzL1FXSm4ybFJMRWFValNMRkZqZnpxeG5oNHhXYmZlMS94c3N2Unlo?=
 =?utf-8?B?dUl2Wm81VzEvQlRlS1NuNlIxOUdQTjVHZUpqSGtVUnlrdnNCbjl2a2xldjQw?=
 =?utf-8?B?NGR5ZElRY2pOLytyQVA1NFJBV092TldBcFM5cFl1RTRpeTdhaGsyL2ZhdjFJ?=
 =?utf-8?B?UkdSc2ZNTDYzMmMzRld0cHNiZ2ZGNEt0STI2dlY1VmFuTWN0a1FZUUNOY3Z4?=
 =?utf-8?B?YTY4cFRiaU1MQzRZQnVtNWc5VWEyaHVDOGsrV3BvWHR5NjJMajFCeGx0NlAx?=
 =?utf-8?B?b3p5R2pMQ2ROdE9SZDE4dS9vQTY0OTJ0NktsSzNmVERPTDh5WTlZMCtWOHFD?=
 =?utf-8?B?cmdKaGJ5YjJnbDZmalhnYk00Zm9IZTZCTlFmdlU0TlpsQmphUE5aNUxLa2FW?=
 =?utf-8?B?N1lsazBLUHhQMllyc0hiQktUc016US82cTRhRHBLUzZaY1laaHNTSUorZ01r?=
 =?utf-8?B?THlpd1d5cUl1Qm1VSlhEZkY3NWpYckVvMmwzZE5aaGd3SjR6bWlQS2ZVR0lu?=
 =?utf-8?B?VCtpSml1TnBXamc5d01DM09jbjhmM0FRNGs4d0x2WkR5U1c2SlAyUEJnSXht?=
 =?utf-8?B?a1diRzRFWURENCtGSEduR2t1Z01zSEdoTE5JellLU2k1eDh0Mks4YmYvdis3?=
 =?utf-8?B?ODR5UGNqQmhSbGJIZjU3U08yYTZsajVkRiszREJSbm84ZzRaZ0h5U3J2amE3?=
 =?utf-8?B?eUY4K3Y2VEtLeDNFdTNyOU0rZHdnckt2L0JlbFN3Myt2bWU1SHNnYU9ZR3hn?=
 =?utf-8?B?aUdxd2FPb3JIV1ZZSzdWbTV4ck9NQWZCNXZIbDZKS0MwaG9jT3BvQVVSSEpu?=
 =?utf-8?B?Y21xZWlnWXpwVHVDNjdueEcycnZkdWgvNFFlenpZeUlSQ0xoL2UxS05DWndp?=
 =?utf-8?B?SWo5Kzl1OXgxM0JkZ0s2akRBSGV5ZnFnLzlkK1RWS21tQlhoQURoc0szNWE5?=
 =?utf-8?B?K20yQ3RQV0xpL1dzREpRWENMdFhnS1crL2U0eU4yZjVmZjVQWnd0ZVVvRlRB?=
 =?utf-8?B?R0JiQ1prUVhpOERMbmhkV1BPVG5ZTkJwU1RwaXhhK2g4TEFBbVdsRDR6TkF3?=
 =?utf-8?B?Sng4Rno0S2VTNXZVN3d5VEg0ZEdIUGV3VGtHYjIxZGpncVQ2SUhBTGtBaGRY?=
 =?utf-8?B?MlpydU9QRzFGbVJLalJCTWNGVnBkbGxLTUVKSC9WeVdwTlZ6NFY3WTIyWDRE?=
 =?utf-8?B?cjd2U2UxUlY0ZmJFbmhZUnY1bTNqaXp5MkhYRlJsMTVOam9NQ0g0ZVdwWHpM?=
 =?utf-8?B?SkpGZXlUU0J0dkpJSk9GS0Y0dkdkYzBLc1hVUUo3bEZTSnFxalF2bXN0ekpN?=
 =?utf-8?B?amdmR2RuRkR5R2dTRUFnbXYrZ2FnTzQ2OUFrYTkrVElBSmRXMFBVRjErUWkr?=
 =?utf-8?B?ajFDak9qQm82d0J4dVlQUWdQdW5XVXpvTnkzNC9MZk5QNUhadExsb3lnb0Uy?=
 =?utf-8?B?Ui8vSXVlT1dLQURvU2pSbC9UOG5tbUoxMkNxZ0xqT0NMdjRIMGcvb1FBN1I4?=
 =?utf-8?B?d20vdE1YN3ZlZEdCU3RHeW9ZaWRUczEydmtPZU9XWlF1eDBYMTNHVERhRVlv?=
 =?utf-8?B?WXVNU2NkNWt1L0tGT3lMZHBIa2lnYVd1QXJKZDlrRVgxdEFzaDk4WnR0akJS?=
 =?utf-8?B?WmExbFI5ZEVwTGExcU9LOVpidVZWZ0Z0TTZPM2tGNWw4L01WcUlDaitTZVNn?=
 =?utf-8?B?OFZRNUlWa2duVHRzc1pIYXl5VS9zcmYzVm8weW5mMVc1SEFuQWNNejROZ3Nh?=
 =?utf-8?B?SU5JS1dINTQ3V04xTmtJc1I3c3dJUzlnQk9sRG5iSS82bWdzQStMeHFoSEFl?=
 =?utf-8?B?QTV6VDc2cmgrNDlHZWtySmN0SzVLZDE5eW5hV1ZNVVg3ZGRNTVJSTSsxWjY2?=
 =?utf-8?B?Nmh2Q0tvODZGbHUxem1IT0ZseDlncjgxaGpleVlPMmZYbjhmU3RGN0FDNHBZ?=
 =?utf-8?B?b0RGSjlUeiswNlRRenZ1bTJMd2ZNZnM5WEhxNlYrMWcxcUdmem56dW1pcHZJ?=
 =?utf-8?Q?PYh9E3U5LzQin4Z3foVv40XNE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5ca277-f9d6-477c-f1d6-08dbbaaa6745
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB2969.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 13:55:24.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qa+L2ACDdZIG+rf1K9BDHh25zJR71izS8PQ8HzDjQiXUcno/DObV5VkZgib6wy+1qh+0dz13eif25H+kn80nLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9677
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

*** IMPORTANT: Due to its age, branch v28 has been retired. ***

These version were tagged/released:
 * v28.12
 * v29.11
 * v30.11
 * v31.12
 * v32.11
 * v33.11
 * v34.10
 * v35.9
 * v36.9
 * v37.8
 * v38.7
 * v39.6
 * v40.5
 * v41.5
 * v42.5
 * v43.4
 * v44.4
 * v45.3
 * v46.2
 * v47.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v28.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:43:38 2023 +0200

rdma-core-28.12:

Updates from version 28.11
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9CofHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZB07B/9sWQEtMtOYqV0+
P0Rd5sAXjuA5M3JxSbfuxjObZHyH9E+jCMHGPA9UCphMWSrdueBmPu7hsqdUaghu
/Ece74FsYIUH3M81X1HSBklrryAwM0IbLBkG0gYusGQdvQe2kGMXu2fgOmXJxfH1
I/BY+UKl1Jm1puI+6I70GLGNZgSyUqKO6zjqikdp159vgPoBCD+eSluhJVtgxtZt
UXjhCLfFArzWSLsMZdzCahvPJ5OBSvgH/TwQHD+5mZUQ5ZDD0J7kzTkQkmeQeP5f
m15auIGwjPSJaPTaUx4gt4szLuiDa3SMMWC7nB+GYz7hfrOcZWmLZGJhqWz90ugn
l24c4mgT
=IHcu
-----END PGP SIGNATURE-----

tag v29.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:01 2023 +0200

rdma-core-29.11:

Updates from version 29.10
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EEfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZP2CB/96pqHxDbSnRyzl
hgjFnAeYBe8PJdroVMEK3i+4Ro4X04MRG3nIb+pTCS0j0NnbCE/UDxSAjoIoAEAR
Uu4D2QptEI+3q9yU6OVFrLjfusX2HCa3f2WxSnZEhgWWoMjg7fif4E/WGMjHBjT1
l5QmWcvOmciFPzEoooSpWgexCGgaNFR/QkyYSAiolbmdSYAHyCREN30KBJBDlwOX
iobyfQu4SvfSeFJe71RE6yBQRe/1VKkQpSMVO/eJ/z/dp2vu7vbdsXyjsAku8LKb
kLTuhdPWYWLl+VsAHN7RonT4HaDe7CeAEz2apaeuoQABPiuq8x8XFax3VzlYwEk4
QQADJDrd
=XNz1
-----END PGP SIGNATURE-----

tag v30.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:02 2023 +0200

rdma-core-30.11:

Updates from version 30.10
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EIfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZEnHB/0UQLUq/GBjXlSI
pWYo22v2kgO4cctXMNgMY74MqJ6L7rJhYYs7OBu07azlI69elEVZ6HoCwiG5OgGh
46tOdy6oZI8QOjR01w3aIavbok9HLmxujamipAm8aiK6Lh9SElslNrLSxxQM/xTW
0d8i0rXXQaRQKooJOkYqmG8sU2LrMvN8fJmrKlj6QTp3nJXeNXAmbJZIxFq4AKfV
IJN3qwPRBo1c8Zj8xWKDwmLacjyg3nheZ2vaKELRjGc6PsAFOt1kDorPNjqv2EPI
5jt1EbW5upEh/R+jAawlai1r8ePkuUld5FhAL/hc8j4rJZZoCf8a3NZkxrroT0v3
0IjTCpK+
=W8VB
-----END PGP SIGNATURE-----

tag v31.12
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:03 2023 +0200

rdma-core-31.12:

Updates from version 31.11
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EMfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZOJ+B/9lx9ZFWMpBliDp
Pa6Mswz6onhYnjWxknaEwfNO6YZjAQ0L8QXJlhY5w6G7P6KeU20UDjcqD0uKdZ5N
LPdtkDAb68ZbBo6bSrgiJq6YOiacE5+NoEoT9JB23VYmKmbEup9qjEALWvE3eqVJ
iRIMnyMIwPslMYA1uTwBSWtlS1Bq1WSs8IfwJ1cTcceu4LZe/Alfe9ZCDW7iwO9U
UfPmVtqftZ208xjv4OHdWCRIyyFeKzYX3iiZyQExWGvwtGBrWP2zCBxpFuoh/96F
DiVD9pGhSRbfSggDLmbzL2YQ5QA7M7unDjLaNCkXJjvwxLoaoH87AmMeAPDtxZLG
SRfqS/17
=aOpI
-----END PGP SIGNATURE-----

tag v32.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:03 2023 +0200

rdma-core-32.11:

Updates from version 32.10
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EMfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZJfTB/42ZFvcFYxYfm/K
Zf//p+U975u2bSSGdSJHewdUzKAadb17lpChf4qh4+eFElrnDQZz5f5T+QywkPts
jbhzKRh2WfHhn7LUIh2FNbiP+ESxfrK4t+d+k2V/DpIwFVYCclRGYVLoMzcOMb8D
UvPrIKCUcuBQ6oGdK/RjxxSIEv5huP4AO3LCP8QxU99ShskxbzCZbK+enPvyS0uq
OBURW/kTnlgNWgMWrCtbRbMuCnN7A547Le5ytAkb8UBvi9q7PorEi1hEIkuYvq/b
4lgfD8FZZHpzM/3zswq/KSOsBME4qlY1abwillQbzRtN3mfZzKAiEOuKoDwr/7P3
ewq/mKtV
=tSXE
-----END PGP SIGNATURE-----

tag v33.11
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:04 2023 +0200

rdma-core-33.11:

Updates from version 33.10
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EQfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKHLCACJIOmV6VWsqxhB
n6IO0ZFEz5HftMSxGYZgGr96DmwTz9cZrSYmlBsRhHst+o0YB3ArWYJiltiYaRS+
2mbKk1wu1eL1ESxR+6LYXLq9UfXBLYRI8IoutN869ySmPPWV8/La/ZSIWEj9v69c
458HYeB+sb/X8pjQt7xPuvVfEdR5ZXWZX0v0LJXHWlYa1VZK8/LF51APDGC5Xk9+
jEk1CJiEnYG4YHRmzBgCvlZ+R3+EWkufByf/iCjLInVx1qkc4buvED9VAFXGGOvB
ZYc10JymL9T0q5Cuj/q9JD8pThMdjmHguZk1uIPt+4r7xsRz50wOK2ExOCYVlBjE
ZCmmPQaf
=/Y0E
-----END PGP SIGNATURE-----

tag v34.10
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:04 2023 +0200

rdma-core-34.10:

Updates from version 34.9
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EQfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZHvHB/0SWTr/4bSBnwvv
4cN9Dm3cwEz6o5tXrNLT+O6n7edqcueOLzP+rLFy3s6eX4yHoiryspi5+XnOkuy2
LCkq57zG6935lAB7Uc4is+6iGpDLU8Dy/+IfKKk0JPlPpHGEe4KMl9xFa+HRQTgX
dytACzy4rzaytFKjFy7E554EvxRQ8lNtXfwnWqZNnXdksRJQdth/YXmLgSku10KQ
rc868BIafbpwR+7Cp9Dk3lHkfY1Us5w8HiElogF32SVU35A5KvN5D9TaU7F5u8D9
LN8HYUSSt+SR8pGKJvheHKCFLhZigktXMkpD9sRJHL2TVrkObymfBUgiDmF0H2ZY
lVTTN9S9
=y7W+
-----END PGP SIGNATURE-----

tag v35.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:05 2023 +0200

rdma-core-35.9:

Updates from version 35.8
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EUfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZEWRB/48/7d1QLloL6yv
DurhLfZcMTieKT1HMrAu7SthwphmYPZLlrWBEOQR8ng26hInYis2yfLaV3pdsYC6
uIjPpHz0xkU/qrWYakOikZ2sjKqxX8YVU/qA0d3VU3XutRBIDtRJrCsxdkVqRIKQ
gDaHuEaz4/I2P09nDb/CEhFN7ZHcNRiDAIj4b0+ALamC1MUhTJv3be+0adD53YtM
O6ENivmeIR6ybtvht6wbiDsQ3SkNXr3OxHKHskBDzUkXHNX5GHg63eZ7HOKizShz
fXjHq65F2sR8iNYuQPmOUHyi56qTz5nMlD0gA7NNV5yI1MJDvbEyk0VFayjTvIlX
IC3SSNXp
=Kwt+
-----END PGP SIGNATURE-----

tag v36.9
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:06 2023 +0200

rdma-core-36.9:

Updates from version 36.8
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EYfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZJhJCAC0tyJ+1smjVGGq
0ECGPWazWpxcZgJX+GvpXAvf1ZE2/+sVvZfftALMDNZuNA/cA8lXpv3FAWXNGBFz
GhSOJDtbc4Pq5HujvLdYNNcMOaRKxJIxBZiu4dlGtOpb9X5Ct1O91pbgn9w8JLhf
qYn2tbHDByT7j1RrS0Tnp2LlrQGvZgAJr0kEG+ujJ+WhAf6kbAN7WqtAa6RkxB78
tCINisrm8cUUVGpjVhB04i1kIHMm1Kgcv4FIunJX1NAbCGx4fKsXFnWBIcqSKGJx
ySgVjqjQtsYCHX+n8P2Hqxg3mX7Uj//FsIuD5vHLtyglZXa1Gh9zUq1jfks2FUw6
X+yOJi0S
=Z/bV
-----END PGP SIGNATURE-----

tag v37.8
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:06 2023 +0200

rdma-core-37.8:

Updates from version 37.7
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * providers/irdma: Verify max_send_wr and max_recv_wr
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EYfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKW4B/9SQo2IWTINALR+
nY6/TdcuslBai7kvDlKG4YyiNKvS5SPWTJxnaijTRNV+DX3jbCFEDc0q2frGfmoN
BVw1iTUEcBax+Bnh9VmyZPoLt3XMUbMaEpoy7oowqL9lMvDUhZ8xruCEWHyR+rYt
hlJR4imK/cqsrSN8enzajdPoOvcpxI2gb5tD5UNQRKAdBHgRoXXrG/G7qpgXugff
ep/YTJN7TXQmDxxUW7+FoSj+qS1keQSLYqmSamwe7Hsf9p8jKUHr5CY5qOQ6tVZJ
JRan+W8/BvJ7gFGBtvNL+cVgCvMkbPo3YM6/3KMJx60a/zKbMJes86ikxURtZ8be
DNq3Fm0v
=y4Aw
-----END PGP SIGNATURE-----

tag v38.7
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:07 2023 +0200

rdma-core-38.7:

Updates from version 38.6
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * providers/irdma: Verify max_send_wr and max_recv_wr
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EcfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZOcnB/9BHnPbIbs48MFK
4ixb5rkyr+RD8ZtGeNz9mg9pCBjZC2ghaLE9y/u7pCSuWSpIxXJJk/aMXNW13MyU
vOsgPbnQOj+F/zak56/npkj7k2JjMJL/rCxOsoqiKo6IX1t6eZeRz6UNAC2wqKwe
Wqqw9hVQ0mExYpXhrcU2S2Ez/v/OeYv0mhTJzd7dF+AZq6zl/THFXOq9gXt7tmLm
u9CSOFpc6lv32qIvgF9fIsf+p7sRwZUGgDOvLKNG7IayaB/7Fy5A2OkCuqKUqEWc
dzVPeKwQWxMBqOfaYQwFLpysvPIaBpMXnXeD+3byZFfV37sQjbCsVsUrGNnXe8gJ
Y8ypz+jv
=5TLH
-----END PGP SIGNATURE-----

tag v39.6
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:08 2023 +0200

rdma-core-39.6:

Updates from version 39.5
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * providers/irdma: Verify max_send_wr and max_recv_wr
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EgfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZECLB/99QY2nRDHCHkQ1
UAO7LsnYQ40jX+RL1PcAkyQ82Xd9y2A7JYkm4qBUl6N3LrLva5OQqdL4MSt523qW
OmRnq/92gViOiQcdL8l+aVYS3vpMZGI1em3148SuSBr10EFG7icWm+I9wILBGKmN
dMCy7su/pkMJdacIa2NnR0B8tCg03n5XlmbtYwcoQSA3aDtyMB4QTuXfIPQPEpHT
MAroGDvkQL9Kdibzap0AALVkQfCpCSggvm2TQu1zO+nPonjr/MST57DbEWng5gOD
sDmGPJ9pvs/1+yz9y1RP6HdXW8kKNumtScHG8Br+q0TW32iNBLOfkHgBQR2/jJ1p
Gf/8htGD
=LUZW
-----END PGP SIGNATURE-----

tag v40.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:09 2023 +0200

rdma-core-40.5:

Updates from version 40.4
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * providers/irdma: Verify max_send_wr and max_recv_wr
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EkfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZNILB/9t9fUBpw024K+Q
S7AaRI8/XtiAySDukvh+C6ToKEyNvr+b8srEDbHM9JGJ6tUmGP0yTD7pxyKyIdmx
HQHMUSTG9ySH6MutY4Rzh4XwPgTtj44QU1Bbfyzcq2eKOdRLeHQPiWdIKLSP7y7N
g2eTh+FDwh0ymvljgArr5xZyJmss5WHedTbvpOXQKqok9fssl1N3d/nnZs30O2Lv
kQ83sPBAJUWLcN91dlsBhSQI8bli4eopg3cvNQ10LXKmOBM2HgOOdLqtBUITNLde
aujtD7O9Zd/ywhqi7ekWHJRf2HIHuPmt/WDvTRtzO4/is2dsUv1b4yJFan8PLJqb
VTukIAdP
=tMz1
-----END PGP SIGNATURE-----

tag v41.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:11 2023 +0200

rdma-core-41.5:

Updates from version 41.4
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * providers/irdma: Verify max_send_wr and max_recv_wr
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EsfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZMG1CACG4akfZJe/C0lI
krZtrarF+qpZZY+9S4mZDzomElbgnvqOCgW9klRlmagUvXFbBBjRdDhXYafQrUuJ
xejw9Zp7//lH3pPAbYHCdbrRm3mW7i5b0MIH3gf31B3Zhi1I9WOfO66iV68R5BLC
O3IgmJ9Vz10F1RuJeeNF6+PKx/QNMHf80cB+5EC7QoZv3Nu6FaytBjzJzf9p9utG
UX6qgeaxLu8dYVoiTh0mMcEXMUJnnQ0fRInJrQNX+WFfsuZu4s97v8N5g05IDqqL
nCXyvHcKJE8CbJs0gGZZOE4JOBmtAlNbtGSjrOkcH/jShZpBoARvI9gRVenzA+34
w+LPGAg3
=3TTp
-----END PGP SIGNATURE-----

tag v42.5
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:12 2023 +0200

rdma-core-42.5:

Updates from version 42.4
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * providers/irdma: Verify max_send_wr and max_recv_wr
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EwfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKk1B/443pkpbGvg5Z5d
g4oXGhO/jephluYTCu4WK6UUn32w23H2NzqTqiB1yunRc4EziPLbN1KxErRPZABv
Y7N3RjKnwYER/8u0XD2XKutMJpojmWj2YSPZ/YQBlwa3a6Tu11CCo9R+G1kLF23y
mONMR4CCyEqmgPrIIgp2+ovZqpVyf216MNyAu4R3YtljeMg44gvA7JhxYf10+8oF
eS3PFXmpHH2S+A/C12/9H7sOdmILUQQm6wLu8UBH6gjwdudet+eh5ci90+/Tf6uj
ziSC3zziMi6jAk/ElRsIVPg+cmHD9hULVjHu7lDueNYapfkPtQLmuSloOy/eAfHs
EeCENAAp
=y+J5
-----END PGP SIGNATURE-----

tag v43.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:12 2023 +0200

rdma-core-43.4:

Updates from version 43.3
 * Backport fixes:
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * providers/irdma: Verify max_send_wr and max_recv_wr
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * tests: Move RDMACM tests to be in one direction
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFSBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EwfHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZNCHB/doOhCAA1wKMD1s
kZnMaz1VupWF9xeyMMGnmRCVvvdPx7zvlFWlqkd8iFvy20Au6OGu2AOzoCxe7lcg
RhjRXZHx+VdGU+6Yunkwnb4f1VYYePHI1/sIq+wKjByJbDZKW7HSWJ8knwXTQ3XG
lFiJ2kJaFWEZ+gsLRQTOytDXZ8xnfN5qXOehOoT5ZZXGSmBV8UeO1EonfNY1gseD
VcUKeUdTf6XAdYgCmYHiIkl1oQuyl9monDWRaZofgCOW9afhtajOFBQ8Hpif2jJG
OF7YhLPH1zMLBrHny9p+bQHXiRqLY9d0G1TBthwtP93CA151ZHhzy/LZvIRJu1bX
llCU0Ps=
=/bOh
-----END PGP SIGNATURE-----

tag v44.4
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:13 2023 +0200

rdma-core-44.4:

Updates from version 44.3
 * Backport fixes:
   * pyverbs: Fix typo in DrActionFlowSample creation
   * suse: remove obsolete defattr macros
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * providers/irdma: Verify max_send_wr and max_recv_wr
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * tests: Require being root to run test_obj_on_huge
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9E0fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZDv3B/wJzl2G4jMJc6yd
EU3jc3xKPmK2sKY8ZEhAo8XF+g3LnOlexHWoXSK5P4aGDxYtrNaJpc3Ojf04rfbs
hhaLbbJRZ+5cFNcWlin47jkl+5RP+KVSzWzrzXQv9qY46IC6+ITVUh6q9LR082G8
uYlVPPqqEiHWf7/vUahosYXDL2inQgxw5Dtv/j4vQWOwQBhXbGhCVlPEDfFMaYIK
LNo0WH3x4lGmmprnLg8SW0y1JDXXAGFAjNsZKu4CIkg/x3+BTsrtL8ldgAJBd4Sj
nFkEl0RRJu/Vc3nWToEUX4tV1ku0xBJ5Lq4mUdtK7jtpvAyamdh7Z0SN9Qt3GtpS
TRxhQ8Cv
=RPcH
-----END PGP SIGNATURE-----

tag v45.3
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:13 2023 +0200

rdma-core-45.3:

Updates from version 45.2
 * Backport fixes:
   * pyverbs: Fix typo in DrActionFlowSample creation
   * suse: remove obsolete defattr macros
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * providers/irdma: Verify max_send_wr and max_recv_wr
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * tests: Require being root to run test_obj_on_huge
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9E4fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZDVLB/4gyJkouc7zqwlk
7RYUiGLyCGxTHlzF3xyUt9NrjDgTM6+5e10/qOjlSCVj2uZwB3hDkTC6OeMtE69y
7N1hyDCROdJjp9Ls9geQGVpQ+XG1vG8ASJ0x3DAF8UYRxqR72lfbhUw8G93FNSV2
OlNLmjrgw8/2LmOr1gFJzjj6XEJ74fH1sBbNdozuLZkC2XI7fquGnBsXoJ2j1oAf
TFVJznEcNdhRwYSOX5VgGR9WcVij5QGtwJZp0ajkZEwAIxGsEtAbDlpVIuluuXry
+Da7ySGXQAenw5zfdkLM3zsN/6zOTirV6VhN2mZ3V/dQUj7AyiqSpQ6g7gBHe96P
SA+bnJUT
=QH39
-----END PGP SIGNATURE-----

tag v46.2
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:14 2023 +0200

rdma-core-46.2:

Updates from version 46.1
 * Backport fixes:
   * pyverbs: Fix typo in DrActionFlowSample creation
   * suse: remove obsolete defattr macros
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * providers/irdma: Verify max_send_wr and max_recv_wr
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * tests: Require being root to run test_obj_on_huge
   * pyverbs: Fix randrange deprecation warning
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9E4fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZEfyCACynJCh9sFrOqdV
ksE7TX6Aiu0BzxZc3dji7ehGzqINnHCLd+FvzJk+v6mdGl3SK82IVrmvlZiTgWBT
CG22FYBeFerl5xg3gjuFwcySypPZSsig7xJXQSiELf57iatN9dncFarBykInv6TN
mbun6TmNg5LqyYuGJ0vivuyxnD8KGH1RuRKRDddXYO8VqfJNN7s9sEm3eigaS7kQ
tGRNiwhU4w/1gqMbwe+IugdS5eFV+6X3lvD95fiNW7CcksabBWBFgl4QUbO1WgjA
Vp22YjwiDXjQOoGRnLp6BzM/KH19LaXhGDkP7f5C59Ucx+4OCXuI3zq8Sf6/CL5K
ZHxp6soX
=bhqz
-----END PGP SIGNATURE-----

tag v47.1
Tagger: Nicolas Morey <nmorey@suse.com>
Date:   Thu Sep 21 09:44:15 2023 +0200

rdma-core-47.1:

Updates from version 47.0
 * Backport fixes:
   * pyverbs: Fix typo in DrActionFlowSample creation
   * suse: remove obsolete defattr macros
   * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
   * providers/irdma: Verify max_send_wr and max_recv_wr
   * mlx5: DR, Fix dest-root-table action for NIC TX
   * tests: Fix rdmacm async udp
   * librmdacm: Remove not exported symbols from linker map
   * libibverbs: Remove nonexistent symbols from the linker map
   * tests: Require being root to run test_obj_on_huge
   * pyverbs: Fix randrange deprecation warning
   * stable branch creation
-----BEGIN PGP SIGNATURE-----

iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9E8fHG5pY29sYXNA
bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKIQB/wJbRXqhJSzbrdy
sTpipPQlYbRk+o44kppzihEp/wsB7wTbzauQBnw2I8tuVImApkGNHG1o6OPchVLK
IHcxSGbbJX9U/cn7fBxCzHlVCWGW+WZQ+esBA/1HY4GyD772Ncgg86AN0R4dz585
BrEAYxdxDcNVB4ZdIWejgZQWodtK0YdRXFX15KhQT3IiVVUmwgEecY4gSp2jC8df
j/6ptAWbeJrd/bTyHzBWFRV/P3y2GaNRiUqkp7wGbOjHmt9qVmQTUG/pUYJK/8QB
Wip2a/Sb+f/fI/M/CX+42wBwR4TgqSCHH8vhNeMhthoF3lXhuj4YEbDkrnHfCBXb
5kBCCJ8d
=uLHZ
-----END PGP SIGNATURE-----

