Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675E16160B4
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 11:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKBKR1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 06:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBKR0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 06:17:26 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE64524952
        for <linux-rdma@vger.kernel.org>; Wed,  2 Nov 2022 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1667384242; x=1698920242;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=yRg3Yl+j+rShmf8k2xQqUdqsa3VQ87dxpcaIxUDEUjo=;
  b=biGJ0TK6UX1nosCT11MkY98CEo9jNvo2HzWUcOipIoffslugcGezRbav
   ZnEJo3wBQo0PaIMb82xnHNjdYIIwwn3EOh3ZDjBSsY9N/5r/lVYwR0iDc
   XKshMjWpBP4l0YMJA2PYbonE2kYTv0dBQ+VNJqrhVI4rLtKLCDAiusbG3
   Isbl7yYTJbS9UgMGLGiiMc+z2updCZqMgqihLJMd4UXMMhGxrOq9OzPBp
   O3b0rrepoPBSIfMcTtTEtguvU+UF1uU6evCePlYBGrj7eu8WRjYGmbL4M
   mxJey95+0R01B5BWHYA11Ze59EK//0okYufESFC4Lt4zkkzKwUDH+coHd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="77284293"
X-IronPort-AV: E=Sophos;i="5.95,232,1661785200"; 
   d="scan'208";a="77284293"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 19:17:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdtPLKMoYjWS9UNVZD/AZwrQFQdCbMmCPXPmoUdr2nyWwM+P8hhZj4u7ewkHR0Ca7l35Zgawh5yXra6NB50LWMi61ydyt/jmvZgMp9PuDu8YR6bcu+iJtaBdhWfz7b38CLNVRbX/Ay9eytd/z7kAhntqDSHgZzrHy0/6eXK21cNc99vxVjwEv7Kz2n4OlR1L6Fg7KmLevO46SmrZxCW4R3TWg0Zvc9FMpcJcpDgYBHr+pBTRA5XVxAo648juQ7GlETkcVSeJx01ANYa5T+v6Wet8+D6ExYlatiHEbGAMdeAT84Pwn8E+cQeUeVT0AcctEf8luQ/dBN+Cv3vojCMVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJLf0jAhyuN4vvUKeuYFqGnpqZW0riLe3T6nfqtJRm0=;
 b=gyO+PFwSrA0JI3fxZ1gFOlw+eX9ZiCyzv5Eyf7cAXYTpASlWFy2aPbDJi7n5/RNusIK2n+2+77YLX5UnFao1bvabTRZiWP3yefrC49/eUG3JMZvMzbSROsNhm0PaBE9vekV5U7XuE/MzzbCd93Nbpbm4tlcp0WKcgto0Da53cMX8xgLCugRO4QSFDg5J1HSDiesmP5YumcIIxI6Yrqp/K0/ebw2YNY50Kj0HTiS3dPlBzDURklKqMYYtZF3AKZesh4WTl8YgtmjnuKsP5nf9n6U/rV8Ly6iQd6Vc5OLMkS56oDJUkg1/57uKFCJkKO6HfJFB1wvDU0h93Hr2vxQsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYCPR01MB9401.jpnprd01.prod.outlook.com (2603:1096:400:195::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 10:17:14 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::8f33:6006:986f:f575]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::8f33:6006:986f:f575%4]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 10:17:14 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v3 00/13] Implement work queues for rdma_rxe
Thread-Topic: [PATCH for-next v3 00/13] Implement work queues for rdma_rxe
Thread-Index: AQHY60QPhEmsfEs6mEOBpNno2u2Vq64rPfoQ
Date:   Wed, 2 Nov 2022 10:17:14 +0000
Message-ID: <TYCPR01MB8455A2A6E317C08E2F9DF908E5399@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
In-Reply-To: <20221029031009.64467-1-rpearsonhpe@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: f035c8b60d08463b9a7809eeedac9e21
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-11-02T10:17:12Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=00fe9382-5d4e-44cf-bc64-4f87485beb34;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYCPR01MB9401:EE_
x-ms-office365-filtering-correlation-id: fc241a8a-6b27-429f-1b15-08dabcbb69db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqhwImiQs7MGBkZZ2zkSjPkA68ot4V0RHB+8f7Gl/hpn+ZuAP5tsUdUFBxAJybwkw+MUSZ47IparFVdbFimcJXEKpugQrdFeWu/ebxaTrRvGkq1j8hudYzX45jKelS9Jh5pc30cvwlkQbaD+1fVHNNhMkdRfGxOfa9I2BfmWlOzQUrDeo64mRezECS66wkhtHyGsKQCL6wsESR3IhbL/UsL5r5/dw70QsCI/m1I95tKfdExi5KKEj3u8jb2bzwS+1KPCU3xBKM6vAH4ipjFb2bNVSbGCFvcvU4Gm+yWwzhIf8KG15RMOMxHBQmPykE6i12roEzLp8HQRkJO2PLietL0r35I9S40ovZE4Flftm1TYASnRbWst1vE3kO7UlD5BlIWm1TUCeCJNx+WeZn7fE1rXDIIwymWjMkvd4n8hqNo/knAijknNrkouBor4SSjVbNTArWIQmjYNchjkYDYUnN0fILLjt5m2rU9ZfBQC2UnRpvy5E5ENyACqwgoYgIoZUszgjkwTlRayu2tj3YlL0wIsc4n7QhGwhxxgWlh4cPwK0IAwD9fV5Dz5CBmAVAy4Kh0RGE3ZnLo5NKbMKgwcmEgILJXD5MyXGTziRBO4aydcxcKZ5VSIsi+IBgYCypkrNpLtzrY9iJy7IOST51akUMs41BGg37G1Dl/zxBoeDwmJ/O+H+5sr9J5xOExngbgXXgkPYTfXWCYsrG1YjvvaYg2AxSGJ5fZwPvgXY9a5Wf7yT/iNVWaqAhvOBxmzoOu3SXd0ZZ1oEifj4FpBkegGc5jHSomyQ5/J5ywH3nCYrqdN43AwoMwyI4IgVaozRdjbGKAgPKQRiY6Sn7Ek8r4IMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(1590799012)(1580799009)(85182001)(2906002)(33656002)(41300700001)(55016003)(83380400001)(66556008)(71200400001)(966005)(5660300002)(52536014)(8936002)(66446008)(8676002)(64756008)(38070700005)(66476007)(86362001)(76116006)(9686003)(316002)(82960400001)(110136005)(478600001)(53546011)(7696005)(6506007)(186003)(122000001)(38100700002)(66946007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Qld5V1B6ejhKZlFJUzJYZDd0d0FleUkzZC9QSDFQQU5HRkk4OFFNd1VI?=
 =?iso-2022-jp?B?bXZkVkpsR0NVOGZUMkliamY5WTNubkpYVzVHOVFwWllod0ZWN3FPS2N4?=
 =?iso-2022-jp?B?TzREWnlPWE01cFhRVmRjTUhyb0RvUUp5NVBVS3Q3Nkw1V3JwOTJYVXZT?=
 =?iso-2022-jp?B?VUdQREFsR2xobWc1U3dvRExuV0RFajRjcDhybU81b1RwTDRRQk9ScUZk?=
 =?iso-2022-jp?B?NnBldklOR1hsSWlwdlZWK1I4Ym5MUFdmNy9FMjlWR3FqVWxwVHF4ckEv?=
 =?iso-2022-jp?B?d0l3aE9DVUVsOXRRWnpiVXJGeVhVWVAxZTQzNDQ1OFZHWnZmNG1Icmhp?=
 =?iso-2022-jp?B?S2d1OTNIMnM1bGhyZ2hZVGpmeFNHMHhHZHZmSlUyT3JER3pGa3VkSDQ4?=
 =?iso-2022-jp?B?dHJGandTVUhoeXo4NSttczVIN1A1SktxZDk3Rml2RlVyVldIOElhVW1k?=
 =?iso-2022-jp?B?OFh5TGNSbVlRam5kcWQ2aTJMWW0wR3NGcmN2dmRSRDZhVUpIMmpaVThs?=
 =?iso-2022-jp?B?OVAvOW9XK3V6QWJxMWplVEpZNzg5R3RUTndINnBtNU1HQVhlZ3B5WDNT?=
 =?iso-2022-jp?B?L3VOckdYdUEzd2NmV2RKWHhWbFZyc2l2Mm5Dekl2SDJLdGhlQnFHRjlQ?=
 =?iso-2022-jp?B?RFZLaHd4blFxdVZabXQvTVBoTnpveFJCTm8yMUNRWHNQanJpUExjZ3pk?=
 =?iso-2022-jp?B?ZHhkSHdtWEljTytBYWh0STcxVU9JT1FtMlRMUjEwYTZ6Vks0QXkxV3Jl?=
 =?iso-2022-jp?B?T0JQbWNrZFVlSzhYM2hBeEVhN3dvc2xKTkdsZjRTVWlJYTR1OWN1Nzkw?=
 =?iso-2022-jp?B?TEdNN1BtRTkrVENQT28vVzhRM2xDdnVhVjhIMkRUbEhEUWdSRGFPNERR?=
 =?iso-2022-jp?B?ODNMZ3ljbVRieFBNUmhSa0lldExXYWttQVMxeDFQTGNZcGFWbm9FdEtM?=
 =?iso-2022-jp?B?K1FqUnhjNHBMdDB5bXZPZ1R0RlRqbW9oZ1BqYmN3VDg0Y2xoNFJFZWhK?=
 =?iso-2022-jp?B?RElMZlVwSy9YdmhxRWZZMFJyWVl5TjE0bUYwVEt1SCtNSHdCbklPaHpn?=
 =?iso-2022-jp?B?VDMzSVhuTmtBM3VIcHBsM0kwVWlLeE1ZMS9BQStxQWFXSEpLRGxsS3Rt?=
 =?iso-2022-jp?B?Qkk0R1RhSG9JUXR0Z1FRZDhMUFRzSW1uL2dYWTN0T012NkdsbW0zV25K?=
 =?iso-2022-jp?B?SXV1K253U0huU3lSUkhJb2hWVkQ4SlhpREMxYmZsWjZtd05uOGhwY2pX?=
 =?iso-2022-jp?B?S3RvK3VZcjV6b1VhK3dXRVlzR1dQdUo5cTNrWEFLdmV0RGNtZUFCcUFu?=
 =?iso-2022-jp?B?eEtpOFB5OFd4WWVjbFdabzZHdTFEbC9mVTVLY211R1Z5TmZLWHRvenBj?=
 =?iso-2022-jp?B?WE5TWGFtSUNYd1JTTWNrTFcrQ2pTY21JZG9ZclV3WUZpQnFjMjFDNDZa?=
 =?iso-2022-jp?B?V1h6SVVveGJjMDVZOFUxMXdqTHlOWU10UnE5b2o3M3QrTzRVa0F5WlBu?=
 =?iso-2022-jp?B?TmRBNUM3eWUzVmVMU1hmQjdpNXhlVUhJNjAxQjNFd0YrTlhucmZuZkYx?=
 =?iso-2022-jp?B?bTBqS3ZXWmpSekxvRzF3dXNycnhrblBkT2RnazA3bTJCekZhdDlWQ2s1?=
 =?iso-2022-jp?B?MkluSHhFV1RMWE9OMXY0a1RabTYyaWJsNDgveUhlR25VeEY2RzRwZU1T?=
 =?iso-2022-jp?B?YndScE5PTjZoelhqYW5lWUZHN3NDbTlaZGdHQzIxZEdVR25GeklIL0hP?=
 =?iso-2022-jp?B?ZU8xZGZ5N3ExRkpEVUtiWmNyN3VUYVgzTjUvN3JaQVJYem5LeDlFWE9J?=
 =?iso-2022-jp?B?d2s0WERaSmZ6N2JaamV6VDdDZ0g3YXN5cHNVdGw2OGhRYUJjQ254MXln?=
 =?iso-2022-jp?B?eGhhZUJMUFd3ek1MTEZVeWNsS3RpVzNoMXlQc1Z2TndWdHhWM1dSMFM2?=
 =?iso-2022-jp?B?S0g5UnkrdmJVTEpvdUQwS1RPRTlNYmFnQk9xUHdIU1NIbmN1emRBUjJ5?=
 =?iso-2022-jp?B?QkczdzF3cDJVN2l4QWRxdUZQSGIydVNaa1VBNnBpeDdjaDRGZFRsZXVB?=
 =?iso-2022-jp?B?em5zd2FpWGoxbmI2cllNajJxUnRPUHA4djdSeXdLL0NzREs0eUdFTGQ4?=
 =?iso-2022-jp?B?SWpwUVJwdThpUHExVG5kVy8ra3ZwcjZSVlJUdElTQ0t3dnJyVDAwZkp4?=
 =?iso-2022-jp?B?K0xrS1dzcW5iQzlSME1IdG9ENVRaVnZFT1lVYUVGVlFzVEZtOXFqRWpn?=
 =?iso-2022-jp?B?bEhPTDBVUmFodjNlbzhFM0Q1UXNrSXRUaVVkUnhxWkRjZ3o0ZGdWYlFR?=
 =?iso-2022-jp?B?MDdoQkxyclBGQTJ3N0dzVVZ1eGVVN1pQT1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc241a8a-6b27-429f-1b15-08dabcbb69db
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 10:17:14.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVRNZLBF8Ach0pdKuEqQcy88wTYmyZVALfdpVneK0XgKf5cwAMH6O/k4w83TApXKOwVrArLFR0/7BS6T7gBN2vXIgw3jbDBYF9t41HHtCoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9401
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 29, 2022 12:10 PM Bob Pearson wrote:
> This patch series implements work queues as an alternative for
> the main tasklets in the rdma_rxe driver. The patch series starts
> with a patch that makes the internal API for task execution pluggable
> and implements an inline and a tasklet based set of functions.
> The remaining patches cleanup the qp reset and error code in the
> three tasklets and modify the locking logic to prevent making
> multiple calls to the tasklet scheduling routine. After
> this preparation the work queue equivalent set of functions is
> added and the tasklet version is dropped.

Thank you for posting the 3rd series.
It looks fine at a glance, but now I am concerned about problems
that can be potentially caused by concurrency.

>=20
> The advantages of the work queue version of deferred task execution
> is mainly that the work queue variant has much better scalability
> and overall performance than the tasklet variant.  The perftest
> microbenchmarks in local loopback mode (not a very realistic test
> case) can reach approximately 100Gb/sec with work queues compared to
> about 16Gb/sec for tasklets.

As you wrote, the advantage of work queue version is that the number works
that can run parallelly scales with the number of logical CPUs. However, th=
e
dispatched works (rxe_requester, rxe_responder, and rxe_completer) are
designed for serial execution on tasklet, so we must not rely on them funct=
ioning
properly on parallel execution.

There could be 3 problems, which stem from the fact that works are not nece=
ssarily
executed in the same order the packets are received. Works are enqueued to =
worker
pools on each CPU, and each CPU respectively schedules the works, so the or=
dering
of works among CPUs is not guaranteed.

[1]
On UC/UD connections, responder does not check the psn of inbound packets,
so the payloads can be copied to MRs without checking the order. If there a=
re
works that write to overlapping memory locations, they can potentially caus=
e
data corruption depending the order.

[2]
On RC connections, responder checks the psn, and drops the packet if it is =
not
the expected one. Requester can retransmit the request in this case, so the=
 order
seems to be guaranteed for RC.

However, responder updates the next expected psn (qp->resp.psn) BEFORE
replying an ACK packet. If the work is preempted soon after storing the nex=
t psn,
another work on another CPU can potentially reply another ACK packet earlie=
r.
This behaviour is against the spec.
Cf. IB Specification Vol 1-Release-1.5 " 9.5 TRANSACTION ORDERING"

[3]
Again on RC connections, the next expected psn (qp->resp.psn) can be
loaded and stored at the same time from different threads. It seems we
have to use a synchronization method, perhaps like READ_ONCE() and
WRITE_ONCE() macros, to prevent loading an old value. This one is just an
example; there can be other variables that need similar consideration.


All the problems above can be solved by making the work queue single-
threaded. We can do it by using flags=3DWQ_UNBOUND and max_active=3D1
for alloc_workqueue(), but this should be the last resort since this spoils
the performance benefit of work queue.

I am not sure what we can do with [1] right now.
For [2] and [3], we could just move the update of psn later than the ack re=
ply,
and use *_ONCE() macros for shared variables.

Thanks,
Daisuke

>=20
> This version of the patch series drops the tasklet version as an option
> but keeps the option of switching between the workqueue and inline
> versions.
>=20
> This patch series is derived from an earlier patch set developed by
> Ian Ziemba at HPE which is used in some Lustre storage clients attached
> to Lustre servers with hard RoCE v2 NICs.
>=20
> It is based on the current version of wip/jgg-for-next.
>=20
> v3:
> Link: https://lore.kernel.org/linux-rdma/202210220559.f7taTL8S-lkp@intel.=
com/
> The v3 version drops the first few patches which have already been accept=
ed
> in for-next. It also drops the last patch of the v2 version which
> introduced module parameters to select between the task interfaces. It al=
so
> drops the tasklet version entirely. It fixes a minor error caught by
> the kernel test robot <lkp@intel.com> with a missing static declaration.
>=20
> v2:
> The v2 version of the patch set has some minor changes that address
> comments from Leon Romanovsky regarding locking of the valid parameter
> and the setup parameters for alloc_workqueue. It also has one
> additional cleanup patch.
>=20
> Bob Pearson (13):
>   RDMA/rxe: Make task interface pluggable
>   RDMA/rxe: Split rxe_drain_resp_pkts()
>   RDMA/rxe: Simplify reset state handling in rxe_resp.c
>   RDMA/rxe: Handle qp error in rxe_resp.c
>   RDMA/rxe: Cleanup comp tasks in rxe_qp.c
>   RDMA/rxe: Remove __rxe_do_task()
>   RDMA/rxe: Make tasks schedule each other
>   RDMA/rxe: Implement disable/enable_task()
>   RDMA/rxe: Replace TASK_STATE_START by TASK_STATE_IDLE
>   RDMA/rxe: Replace task->destroyed by task state INVALID.
>   RDMA/rxe: Add workqueue support for tasks
>   RDMA/rxe: Make WORKQUEUE default for RC tasks
>   RDMA/rxe: Remove tasklets from rxe_task.c
>=20
>  drivers/infiniband/sw/rxe/rxe.c      |   9 +-
>  drivers/infiniband/sw/rxe/rxe_comp.c |  24 ++-
>  drivers/infiniband/sw/rxe/rxe_qp.c   |  80 ++++-----
>  drivers/infiniband/sw/rxe/rxe_req.c  |   4 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c |  70 +++++---
>  drivers/infiniband/sw/rxe/rxe_task.c | 258 +++++++++++++++++++--------
>  drivers/infiniband/sw/rxe/rxe_task.h |  56 +++---
>  7 files changed, 329 insertions(+), 172 deletions(-)
>=20
>=20
> base-commit: 692373d186205dfb1b56f35f22702412d94d9420
> --
> 2.34.1

