Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE0566B550
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 02:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjAPBsY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 20:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjAPBsX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 20:48:23 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977A93A91;
        Sun, 15 Jan 2023 17:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1673833701; x=1705369701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q20ufEzwglSHgGJRGzTOPqe+T9nEA1Z1J2+o1DVBXj8=;
  b=CbcsomavY04DT0WxuYhjLuGIWd8b09RspXNCEogkYg6bhrOILOZEzA0Z
   Ungiynx5oWliBztNJVQsi+ZyuTCdoS2zhoCdab7SK8fsrz42mUTG+jdF9
   5/KPL1WXfE6AwY0p6Wd2wGAp84Cx0/0Y/IWHJDx7Fd6vkyUqfBGZBalbF
   TW/UjL94tHJD76uUSDIqJjnrr2tRiaHMwrfCLapJhc89I/7IZGJbQ7jko
   Xa2uUjGX/tx1J1rFh2bKsroK6Xi2wJr9B/SFSLN2FhsZFE/Shiql6QyXu
   lR45TSrmIoklZM2e8ttPIPs4PsMn6XJATF4utoTcNOcaUdVKeuA9e7bdZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="74757860"
X-IronPort-AV: E=Sophos;i="5.97,219,1669042800"; 
   d="scan'208";a="74757860"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 10:48:17 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8ut8g8tQvyIpN1pUrVrvbmbCiH9I5y9aODcYQUJl1SbEhexIgZwYYn0B7jEvuPRzGZYUEuTnFAsD0ZoMQqbS91AZA3RlbZ06fJi6/9YSrIPgNWG3ktpSY523LHAYe1OCLh6ChRht3VpoYUy1xkhShY8Ms7xaj3pWdoOfR0rYHToF8sqe5t7c7nAwwaLplJMM9J7jDov1Y9aMTEICt2q1FCE9Q+yDGB0N03DyUY7vfmlHuAwJVuoh+aypMgSZftJG/iW/uX+9OtvMiKfAyKgG+vGhHgWmM47CI7riH9tWgbZ/+MoluZZ3zE2F2XHvBwQBHEZIQQPCVZx3wDNV4R7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q20ufEzwglSHgGJRGzTOPqe+T9nEA1Z1J2+o1DVBXj8=;
 b=Ji+XGAPlGzz97n8zggYoDE76XwxFrepqRMcLUmDwwSVspyQdq1G/NN31iNp3v9nk+CTzPkQcCrRB7Wz3IKUVWEMwPY1mzfQ04cksDmoB82R4JIyi+FuLmH4vBTKrWzRJZkTBHik+Hlkv5BX3vTk7DEombxJaNFh5Pe4qBnoU58RxnhoiHSJWfnxDT0UifoJaZFa0lNYwWXoqV0K1EaLUhiPFVjv+FmhmgY00uVJ8xaasa4kmj9nXvGjbn9X6zev1bzpv3jNzX0eBVyeuTL4AZlKmHDGNXTqif9qf5RwGOSnBH43GzL21nUmA/Dbnt7HM5iiZOlMMHDMAp4S8URNmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYCPR01MB7869.jpnprd01.prod.outlook.com (2603:1096:400:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 01:48:14 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::bb20:2461:b1ee:e8c4]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::bb20:2461:b1ee:e8c4%8]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 01:48:14 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Jia-Ju Bai' <baijiaju1990@gmail.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: RE: [PATCH] infiniband: sw: rxe: Add NULL checks for qp->resp.mr
Thread-Topic: [PATCH] infiniband: sw: rxe: Add NULL checks for qp->resp.mr
Thread-Index: AQHZJve+lxWhkktCA0mQYtGLh4FNgq6b+mQAgAAO6ICABDpaoA==
Date:   Mon, 16 Jan 2023 01:48:13 +0000
Message-ID: <TYCPR01MB8455FC418FD61CAEE85D0D9FE5C19@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20230113023527.728725-1-baijiaju1990@gmail.com>
 <ec0e983b-15fb-e43f-90e2-d4f79d27298a@linux.dev>
 <c7748a2b-2c27-d171-810c-f3eb56120944@gmail.com>
In-Reply-To: <c7748a2b-2c27-d171-810c-f3eb56120944@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 3fabbbf6d6ba40bd8d39c216001075b9
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDEtMTZUMDE6NDg6?=
 =?utf-8?B?MTBaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0wYzg4Y2I0ZS02ZDBjLTRmZDct?=
 =?utf-8?B?OWMxNS1iMzliMWQyMWY0ZjY7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYCPR01MB7869:EE_
x-ms-office365-filtering-correlation-id: d1488982-ee3d-486c-887e-08daf763bb2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ijlTekW0InChQeuAU7FptQQm4Todr6GfpLnqHy350YDpG5u06KJowlIh3uYuJiP+xr0Staz/smApqcjAbT/fYAOwy2tSvFXiWcCE93JtI2TazMS4aln+nPV2VtFiSozSm1VLeF6+rvKyyaQF1fZl0wev1a0OipNtIZ042f+LwfCJUYfmHcFzUdr9bcv7qNoVV72B8UT2DLWiMEHvRZ1X7RrRY3LcnkOi/JCXJ/LZizOWRJmoCEt+MVB4Gm0FtFxLFRGvXI+8kq+/SjFQoxdrOFGhe7QyXUij+BbhIjDboQLx2/HBMvnE/8HDb683OxULqvqVQk3vAJtV39roRQjJUa+pzGIy1MmDPeakbdh0XM8UGcFVGQex9i96RsYyx2/nfcCBvLx6mvc0kTzuWcM0mfaptsPIrjo6SXuDZZtBDWlKsa7nqWqMC01M7WebnFcxHjZ/F8B0gg9g+fi8d6it+jK0E0CE/ieaM6M62HVMDbitMIxSUB9IMQuuL85qoZMwhGP1iNja6NmdGhsGdqsPoOhAP3Ausp5pWwQgl83v9Q6jLQMuhSP5job530LjG+p85AyxE3qklE0lmlybzvrbb1JBu7eHNUJvC/U5HOUO/XkWHbASzpebelCC8kXMq0iNnRWgO2LR8NBe3U6FoOkgU35DerVm+acoTxeKOw9rlrhT78X9UdCwtvBr67+XkPiCzoR96zKhPk2A9w/8MdAmTWLD/lNKmevChOY5E30t9Jg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199015)(1590799012)(8676002)(66556008)(41300700001)(186003)(122000001)(52536014)(5660300002)(66946007)(76116006)(66476007)(4326008)(66446008)(64756008)(82960400001)(54906003)(38070700005)(1580799009)(110136005)(8936002)(316002)(2906002)(38100700002)(71200400001)(85182001)(7696005)(478600001)(86362001)(9686003)(55016003)(53546011)(26005)(6506007)(83380400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEh0YWNqNlNabTFVVU9IaUx2bWV0SWRzakcwempxbFBrcElvRXZqZG9DQTJD?=
 =?utf-8?B?aFVmdXVlRjBFNE55QXBwK1ZUR2YxY2xNVHlDWUZnMCswOVU2bFdGcllvMTBp?=
 =?utf-8?B?cUlQWE1qTW1UZytRRytXZE1FNGxPNG42emVFQzcrUXF0TjJ3d042VDB2eFp1?=
 =?utf-8?B?ZzByektVZlhNUjQ2V084MnNxN3daQmRFamZpRTFleUtOYUFiMGdtNnB1T01B?=
 =?utf-8?B?MTN6ejZ6SThrVmExU0JrcUVtWU9YYkROdUU1a1Vyb09waS90VUsvUk1BNXhR?=
 =?utf-8?B?Q1JkNzY3Zkc2RmlydE9rejBldFA0MHFhMnRWMUg1bkxKQmE2MGlNMzRWbDdP?=
 =?utf-8?B?eEFsSFhrNm16U1VOclhDZlZlNzlDN3plcTNNRjg1blV3NDZiTjlpcDF6dDRv?=
 =?utf-8?B?LzFOT3hjenJZYTJ5eDNLYTFYMXVPbzN0ZzhHdXdFck5ZSjFoY2laMlpFdTJy?=
 =?utf-8?B?d2kySUZaUmF0cTFMOUFMbE54UVBsSTlCcHlZaGMrUUhnai8xSnJwUnF3RzdF?=
 =?utf-8?B?TW5UMGZNUFVYeFMyd3VTZ0pnbTdEQTU3TmtwYkp0VE9RM1ZsY0V4V09WcDE5?=
 =?utf-8?B?WllWbjVVT0N3Nmp3ZTZlTElGY2NTdHBra3FjbW9OWG1XY2JGR1dPdFRLaTd4?=
 =?utf-8?B?ZDdsMUE0ZHg3Q0lpcUtScm5LQVhNa3VmZjhGK0JxZWtxektxbitWT21jVEtu?=
 =?utf-8?B?MEpuZWNhSXBpRU5pVEJRMnBqQ01mbkdaanFUSExUYTJESE9VOGFoSmYwSjB5?=
 =?utf-8?B?a0Y3VnZ6Z3lMcVRSdUJsRjhMalkzUTlQQTZ5ZnpyYmF1WnQrUzhOVlZxbTZ5?=
 =?utf-8?B?UjE4cEc2ZUx1ai9IVmR3ZlZvWnhxL3IvbjZUT1J6TUxwY2YrSHpHTFI2RWgv?=
 =?utf-8?B?SytCQVpPa1Myeldvb0k1V3g5NmNkNEhxS0pUd3hUTzJ2SlIxWHRndGZVVHZj?=
 =?utf-8?B?QTVKZTc1S2s2cWV2VStFc3NTRFljR25nV1ltWTlTazBNZVE0U2FmQlhHbFdS?=
 =?utf-8?B?VXVyaU53aHpFYjd0ZEZGTXVsZmpNN1VJL2RMT0dSNVY1am1JTTdEU2VKQU9K?=
 =?utf-8?B?cjRVd3djMmRVT2VTTnlLcG1qMVAxdHQzbkZCenVLYVlGcHlubGloWkhaRDNl?=
 =?utf-8?B?WGc0KzdoaEwvcXc1VDBVbmhmNnl6bklIK3g1b25iZjhQWGtVVlptR3cwaVcz?=
 =?utf-8?B?azFmMmN5ZTI4bTRLd0NvajlmblNxSitVcGQ1ck1PbEFFRVVSYVhWZ2E1WTlz?=
 =?utf-8?B?MmhETnFLaHZka1BSN2lFTFVEcWppVC9aTGlSZVZJUU03dVR4a3JMcWFnMXl3?=
 =?utf-8?B?QmtZY2dYSjlZejRMMWg0Z2E2ZWwyZjB4bC90ZFloQ3h5Vjk3SHNRVEdrV1Q4?=
 =?utf-8?B?TEkrVk5scDVUY2JMRmQrQ2kwN0liL2psT3BaUHBlNXlLRzllWk45TjFGRitZ?=
 =?utf-8?B?Rjc5U1VyMFdRVm9Sdzd1WCtmY2dJbnJnOThvQ2VuYU14MHhGOVYrNmpwbE85?=
 =?utf-8?B?SWIzQXRZSHFVb1JScHgwcytKc005QUVsb0JtQWxtdk1tT09EL1NjOCtOOU13?=
 =?utf-8?B?d282VGYrdTROMHZvd0Q3N1o5eWZkRldkYUtIWG4yT2pjeTIyQjNsTVVYNmVs?=
 =?utf-8?B?akhJZnlvVzYwZkUrZ2dPUmNlS01mN0Z3c3VJNVNCc3RieGNOUnJWUE9JZnN6?=
 =?utf-8?B?eWZXMnFuMHdHQkxVV0N1YWJmQVRhMXk0ZFZsT2p2UWw2SzdLWVlJRWswRzRL?=
 =?utf-8?B?MHByTEJ2c1NaRXZVZWNYSnVEa1haU0cycjByaGlMVzUyeFJZZ3FhcDY3UTVV?=
 =?utf-8?B?OTJ5RHd0bjdNMkxpSXYwTGtrRDdOK1p1SDNTRDZndHp5amZEOG1NNFNydmUw?=
 =?utf-8?B?OWZpbGtDNExxYTNMaGtwSEdiS3pJRkl5ZklDWjNOR0JuOExzc3EyTmxyVGI0?=
 =?utf-8?B?bUVjQ1N6VDZManlXckdjTkdWVS9iY1kwVWFKazdKT0NhOEZZaUxFTHZ2eWZw?=
 =?utf-8?B?SFc5cG8rUTlCMHdJSFRaMGN4eGtaS05xMFVvcHJ1eGFoZzRtSHd6MmlDMFNG?=
 =?utf-8?B?SXNxazRPbFJ3M3BleEdJM1VBSC9ZQVNRVGJJNG9UNWZsYnU1TWlvdlpaUlZI?=
 =?utf-8?B?WGp1RitpT1U0UlU3cGZlRThveDFMb1o5N3VydE1XOU50c1dZVWQyYmpmVnpy?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rwOTd8mpEjGan7rZiqCyarIgCnM+F/UJlL+Ar+0EAy7DID/4cVbezk05I32Yxbbq5pf+SbCyCyymnuMcEp6xNXtod1yNOyOW4pK6VoixDGFpdDQYXiBgK7nUQjDhKmFVzaWWS8j7HgE1tg8DfM4VNZ0Mu6fyKXo3Hl93NlgWcMIPGH4rr6CTXs6EUKidSnq3gCkM54UN30V+GFYwbb2bAecLkMuqTwvWsPDIu0sjBC4Ozo8DawQvQ2IPk8uyI7g9dpuuVm8CSFPUOf7JgyzG6smhZlFedcSbfsIrpDGD/GCe74p3O9CkboqVbF3vKIOOoPuv0qs/khDtZLR/3nj7OSI69hX7ptYRPzdmYpbfAUoZDtir2Vuz2laDdiZW8VoFe9SfRE4NjaML5/C+zpPIkxCpMpI5DQMK1v8ijZVWltQ/0AvnGaMpJQNygnUp+uiCteIh2uUV0rfF+PMVnb2E34F3jWpEvwt22LL5n5S80M4sclQX4VsHFhlR15Q58elwN3Z3Vl6dgcasRWn1vXrFvJw0aB4vfQF1GX92tEhTFt+i9bI83U/QYbZOGe9X58SDeJ6iBG03NDiAv6d4h2LebOyQP7KuSqpo8ZEAs6pWmYurG0aavkvv0gdF6rdWVtMy3i71RCy5F/c6O5mTJMxRLBOdggkhaLoi61vDa7k8pShlJsAVdkuD7ACh6Z9zUi8Ae/rDVh28v9Vxol3tcKqpW45PTTeLoCT6yqckXWZSRU9zQgOtY8CBGxdlrJQoxH048Oas1Nx5jMUuJDQZRjvQ6Op+t7sdCacSjbCjM0TWj6Dk3rLqDJfBS9yK6iW6qONFaOZc1oqs1d6pGUEtVcwflF8C0BEENOL2bfjpNHZGe7i9/ZQrHUdeB/y/6bA60n1jZNqNknQDUbRsDTGMJKw3OHlgD1pCv+osjRAd2ExzsF4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1488982-ee3d-486c-887e-08daf763bb2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 01:48:14.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CjCDN+ou/Hd0N3YANUjy6k0h8y7FOIYyhD4vX/Zsni3d6x+FPqIz2Q1axzhzjsG9BCdUjw3kAPEdf8IHp2Uzt59aJ0dWEFvNrJ9oBzWtD9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7869
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gRnJpLCBKYW4gMTMsIDIwMjMgNTo0NyBQTSBKaWEtSnUgQmFpIHdyb3RlOg0KPiANCj4gVGhh
bmtzIGZvciB0aGUgcmVwbHkgOikNCj4gDQo+IEkgY2hlY2tlZCB0aGUgY29tbWl0IDMyODJhNTQ5
Y2Y5YiwgYW5kIGl0IHNhaWQ6DQo+ICJJZiByZXNwb25kZXIgZ2V0IGEgemVyby1ieXRlIFJETUEg
UmVhZCByZXF1ZXN0LCBxcC0+cmVzcC5tciBpcyBub3Qgc2V0DQo+IGluIGNoZWNrX3JrZXkoKSAo
c2VlIElCQSBDOS04OCkuIg0KPiBUaHVzLCB0aGlzIGNvbW1pdCBhZGRlZCBhIE5VTEwgY2hlY2sg
Zm9yIG1yIChhbGlhc2VkIHdpdGggcXAtPnJlc3AubXIpDQo+IGluIHJlYWRfcmVwbHkoKS4NCj4g
DQo+IFRoZSBidWdneSBjYWxsIHRyYWNlIG9mIHRoZSBjb21taXQgMzI4MmE1NDljZjliIGlzIHJ4
ZV9yZXNwb25kZXIoKSAtPg0KPiByZWFkX3JlcGx5KHFwKS4NCj4gSW4gdGhlIGNvZGUsIHRoZXJl
IGFyZSBzb21lIHBvc3NpYmxlIGNhbGwgdHJhY2VzIGZyb20gcnhlX3Jlc3BvbmRlcigpOg0KPiAN
Cj4gcnhlX3Jlc3BvbmRlcigpDQo+ICDCoCBleGVjdXRlKHFwKQ0KPiAgwqDCoMKgIHdyaXRlX2Rh
dGFfaW4ocXApDQo+ICDCoMKgwqDCoMKgIGVyciA9IHJ4ZV9tcl9jb3B5KHFwLT5yZXNwLm1yKQ0K
PiANCj4gcnhlX3Jlc3BvbmRlcigpDQo+ICDCoCBwcm9jZXNzX2ZsdXNoKHFwKQ0KPiAgwqDCoMKg
IG1yID0gcXAtPnJlc3AubXINCj4gIMKgwqDCoCBzdGFydCA9IG1yLT5pYm1yLmlvdmE7DQo+ICDC
oMKgwqAgbGVuZ3RoID0gbXItPmlibXIubGVuZ3RoDQo+ICDCoMKgwqAgcnhlX2ZsdXNoX3BtZW1f
aW92YShtcikNCj4gDQo+IHJ4ZV9yZXNwb25kZXIoKQ0KPiAgwqAgYXRvbWljX3JlcGx5KHFwKQ0K
PiAgwqDCoMKgIG1yID0gcXAtPnJlc3AubXINCj4gIMKgwqDCoCBpZiAobXItPnN0YXRlICE9IFJY
RV9NUl9TVEFURV9WQUxJRCkNCj4gDQo+IHJ4ZV9yZXNwb25kZXIoKQ0KPiAgwqAgYXRvbWljX3dy
aXRlX3JlcGx5KHFwKQ0KPiAgwqDCoMKgIGRvX2F0b21pY193cml0ZShxcCkNCj4gIMKgwqDCoMKg
wqAgbXIgPSBxcC0+cmVzcC5tcg0KPiAgwqDCoMKgwqDCoCBpZiAobXItPnN0YXRlICE9IFJYRV9N
Ul9TVEFURV9WQUxJRCkNCj4gIMKgwqDCoMKgwqAgZHN0ID0gaW92YV90b192YWRkcihtcikNCj4g
DQo+IHJ4ZV9yZXNwb25kZXIoKQ0KPiAgwqAgcmVhZF9yZXBseShxcCkNCj4gIMKgwqDCoCBtciA9
IHFwLT5yZXNwLm1yDQo+ICDCoMKgwqAgZXJyID0gcnhlX21yX2NvcHkobXIpDQo+IA0KPiBGb3Ig
dGhlc2UgcG9zc2libGUgY2FsbCB0cmFjZXMsIHRoZXkgbWF5IHNoYXJlIHRoZSBzYW1lIHFwLT5y
ZXNwLm1yIGluDQo+IHRoZSBjb21taXQgMzI4MmE1NDljZjliLg0KDQpxcC0+cmVzcC5tciBpcyBu
b3Qgc2V0IGZvciB6ZXJvLWxlbmd0aCBvcGVyYXRpb25zIG9mIFJETUEgUmVhZCBhbmQgV3JpdGUu
DQpPdGhlcndpc2UsIGl0IGlzIHNldCBpbiBjaGVja19ya2V5KCkgZm9yIHRoZXNlIGNhbGwgdHJh
Y2VzLCBzbyB3ZSBkbyBub3QgbmVlZA0KYWRkaXRpb25hbCBjaGVja3MgZm9yIHRoZW0uDQoNCkZv
ciBSRE1BIFJlYWQgYW5kIFdyaXRlLCByeGVfbXJfY29weSgpIHJldHVybnMgaW1tZWRpYXRlbHkg
d2l0aG91dA0KZGVyZWZlcmVuY2luZyB0aGUgJ21yJyBpZiB0aGUgbGVuZ3RoIGlzIHplcm8sIHNv
IHdlIGRvIG5vdCBuZWVkIHRoZSBhZGRpdGlvbmFsDQpjaGVja3MgZm9yIFJlYWQgYW5kIFdyaXRl
IGVpdGhlci4NCg0KRGFpc3VrZQ0KDQoNCj4gVGh1cywgcXAtPnJlc3AubXIgc2hvdWxkIGJlIGNo
ZWNrZWQgaW4gdGhlc2UgY2FsbCB0cmFjZXMuDQo+IEkgYW0gbm90IHF1aXRlIHN1cmUgb2YgdGhp
cywgc28gSSBhbSBsb29raW5nIGZvcndhcmQgdG8geW91ciBvcGluaW9ucywNCj4gdGhhbmtzIDop
DQo+IA0KPiANCj4gQmVzdCB3aXNoZXMsDQo+IEppYS1KdSBCYWkNCj4gDQo+IA0KPiBPbiAyMDIz
LzEvMTMgMTU6NTMsIFpodSBZYW5qdW4gd3JvdGU6DQo+ID4g5ZyoIDIwMjMvMS8xMyAxMDozNSwg
SmlhLUp1IEJhaSDlhpnpgZM6DQo+ID4+IEluIGEgcHJldmlvdXMgY29tbWl0IDMyODJhNTQ5Y2Y5
YiwgcXAtPnJlc3AubXIgY291bGQgYmUgTlVMTC4gTW9yZW92ZXIsDQo+ID4+IGluIG1hbnkgZnVu
Y3Rpb25zLCBxcC0+cmVzcC5tciBpcyBjaGVja2VkIGJlZm9yZSBpdHMgZGVyZWZlcmVuY2VzLg0K
PiA+PiBIb3dldmVyLCBpbiBzb21lIGZ1bmN0aW9ucywgdGhpcyB2YXJpYWJsZSBpcyBub3QgY2hl
Y2tlZCwgYW5kIHRodXMgTlVMTA0KPiA+PiBjaGVja3Mgc2hvdWxkIGJlIGFkZGVkLg0KPiA+DQo+
ID4gSU1P77yMIHdlIHNob3VsZCBhbmFseXplIHRoZSBjb2RlIHNuaXBwZXQgb25lIGJ5IG9uZS4N
Cj4gPiBBbmQgaXQgaXMgbm90IGdvb2QgdG8gYWRkICJOVUxMIGNoZWNrIiB3aXRob3V0IGZ1dGhl
ciBpbnZlc3RpZ2F0aW9ucy4NCj4gPg0KPiA+IFpodSBZYW5qdW4NCj4gPj4NCj4gPj4gVGhlc2Ug
cmVzdWx0cyBhcmUgcmVwb3J0ZWQgYnkgYSBzdGF0aWMgdG9vbCB3cml0dGVuIGJ5IG15c2VsZi4N
Cj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogSmlhLUp1IEJhaSA8YmFpamlhanUxOTkwQGdtYWls
LmNvbT4NCj4gPj4gUmVwb3J0ZWQtYnk6IFRPVEUgUm9ib3QgPG9zbGFiQHRzaW5naHVhLmVkdS5j
bj4NCj4gPj4gLS0tDQo+ID4+IMKgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3Au
YyB8IDQ3ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gPj4gwqAgMSBmaWxlIGNoYW5n
ZWQsIDI3IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+ID4+IGIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+ID4+IGluZGV4IGM3NDk3MjI0NGYwOC4u
MmVhZmExNjY3YTllIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9yZXNwLmMNCj4gPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVz
cC5jDQo+ID4+IEBAIC02MjEsMTEgKzYyMSwxMyBAQCBzdGF0aWMgZW51bSByZXNwX3N0YXRlcyB3
cml0ZV9kYXRhX2luKHN0cnVjdA0KPiA+PiByeGVfcXAgKnFwLA0KPiA+PiDCoMKgwqDCoMKgIGlu
dMKgwqDCoCBlcnI7DQo+ID4+IMKgwqDCoMKgwqAgaW50IGRhdGFfbGVuID0gcGF5bG9hZF9zaXpl
KHBrdCk7DQo+ID4+IMKgIC3CoMKgwqAgZXJyID0gcnhlX21yX2NvcHkocXAtPnJlc3AubXIsIHFw
LT5yZXNwLnZhICsgcXAtPnJlc3Aub2Zmc2V0LA0KPiA+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcGF5bG9hZF9hZGRyKHBrdCksIGRhdGFfbGVuLCBSWEVfVE9fTVJfT0JKKTsNCj4gPj4g
LcKgwqDCoCBpZiAoZXJyKSB7DQo+ID4+IC3CoMKgwqDCoMKgwqDCoCByYyA9IFJFU1BTVF9FUlJf
UktFWV9WSU9MQVRJT047DQo+ID4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gPj4gK8Kg
wqDCoCBpZiAocXAtPnJlc3AubXIpIHsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIGVyciA9IHJ4ZV9t
cl9jb3B5KHFwLT5yZXNwLm1yLCBxcC0+cmVzcC52YSArIHFwLT5yZXNwLm9mZnNldCwNCj4gPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGF5bG9hZF9hZGRyKHBrdCksIGRh
dGFfbGVuLCBSWEVfVE9fTVJfT0JKKTsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChlcnIpIHsN
Cj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmMgPSBSRVNQU1RfRVJSX1JLRVlfVklPTEFU
SU9OOw0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsNCj4gPj4gK8KgwqDC
oMKgwqDCoMKgIH0NCj4gPj4gwqDCoMKgwqDCoCB9DQo+ID4+IMKgIMKgwqDCoMKgwqAgcXAtPnJl
c3AudmEgKz0gZGF0YV9sZW47DQo+ID4+IEBAIC02OTksMTEgKzcwMSwxMyBAQCBzdGF0aWMgZW51
bSByZXNwX3N0YXRlcyBwcm9jZXNzX2ZsdXNoKHN0cnVjdA0KPiA+PiByeGVfcXAgKnFwLA0KPiA+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhcnQgPSByZXMtPmZsdXNoLnZhOw0KPiA+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgbGVuZ3RoID0gcmVzLT5mbHVzaC5sZW5ndGg7DQo+ID4+IMKgwqDCoMKgwqAg
fSBlbHNlIHsgLyogbGV2ZWwgPT0gSUJfRkxVU0hfTVIgKi8NCj4gPj4gLcKgwqDCoMKgwqDCoMKg
IHN0YXJ0ID0gbXItPmlibXIuaW92YTsNCj4gPj4gLcKgwqDCoMKgwqDCoMKgIGxlbmd0aCA9IG1y
LT5pYm1yLmxlbmd0aDsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChtcikgew0KPiA+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdGFydCA9IG1yLT5pYm1yLmlvdmE7DQo+ID4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGxlbmd0aCA9IG1yLT5pYm1yLmxlbmd0aDsNCj4gPj4gK8KgwqDCoMKg
wqDCoMKgIH0NCj4gPj4gwqDCoMKgwqDCoCB9DQo+ID4+IMKgIC3CoMKgwqAgaWYgKHJlcy0+Zmx1
c2gudHlwZSAmIElCX0ZMVVNIX1BFUlNJU1RFTlQpIHsNCj4gPj4gK8KgwqDCoCBpZiAobXIgJiYg
cmVzLT5mbHVzaC50eXBlICYgSUJfRkxVU0hfUEVSU0lTVEVOVCkgew0KPiA+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHJ4ZV9mbHVzaF9wbWVtX2lvdmEobXIsIHN0YXJ0LCBsZW5ndGgpKQ0KPiA+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUkVTUFNUX0VSUl9SS0VZX1ZJT0xB
VElPTjsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE1ha2UgZGF0YSBwZXJzaXN0ZW50LiAq
Lw0KPiA+PiBAQCAtNzQyLDcgKzc0Niw3IEBAIHN0YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIGF0b21p
Y19yZXBseShzdHJ1Y3QNCj4gPj4gcnhlX3FwICpxcCwNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IHFwLT5yZXNwLnJlcyA9IHJlczsNCj4gPj4gwqDCoMKgwqDCoCB9DQo+ID4+IMKgIC3CoMKgwqAg
aWYgKCFyZXMtPnJlcGxheSkgew0KPiA+PiArwqDCoMKgIGlmICghcmVzLT5yZXBsYXkgJiYgbXIp
IHsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChtci0+c3RhdGUgIT0gUlhFX01SX1NUQVRF
X1ZBTElEKSB7DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IFJFU1BTVF9F
UlJfUktFWV9WSU9MQVRJT047DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8g
b3V0Ow0KPiA+PiBAQCAtNzkzLDE1ICs3OTcsMTcgQEAgc3RhdGljIGVudW0gcmVzcF9zdGF0ZXMg
ZG9fYXRvbWljX3dyaXRlKHN0cnVjdA0KPiA+PiByeGVfcXAgKnFwLA0KPiA+PiDCoMKgwqDCoMKg
IGludCBwYXlsb2FkID0gcGF5bG9hZF9zaXplKHBrdCk7DQo+ID4+IMKgwqDCoMKgwqAgdTY0IHNy
YywgKmRzdDsNCj4gPj4gwqAgLcKgwqDCoCBpZiAobXItPnN0YXRlICE9IFJYRV9NUl9TVEFURV9W
QUxJRCkNCj4gPj4gK8KgwqDCoCBpZiAobXIgJiYgbXItPnN0YXRlICE9IFJYRV9NUl9TVEFURV9W
QUxJRCkNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBSRVNQU1RfRVJSX1JLRVlfVklP
TEFUSU9OOw0KPiA+PiDCoCDCoMKgwqDCoMKgIG1lbWNweSgmc3JjLCBwYXlsb2FkX2FkZHIocGt0
KSwgcGF5bG9hZCk7DQo+ID4+IMKgIC3CoMKgwqAgZHN0ID0gaW92YV90b192YWRkcihtciwgcXAt
PnJlc3AudmEgKyBxcC0+cmVzcC5vZmZzZXQsIHBheWxvYWQpOw0KPiA+PiAtwqDCoMKgIC8qIGNo
ZWNrIHZhZGRyIGlzIDggYnl0ZXMgYWxpZ25lZC4gKi8NCj4gPj4gLcKgwqDCoCBpZiAoIWRzdCB8
fCAodWludHB0cl90KWRzdCAmIDcpDQo+ID4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gUkVTUFNU
X0VSUl9NSVNBTElHTkVEX0FUT01JQzsNCj4gPj4gK8KgwqDCoCBpZiAobXIpIHsNCj4gPj4gK8Kg
wqDCoMKgwqDCoMKgIGRzdCA9IGlvdmFfdG9fdmFkZHIobXIsIHFwLT5yZXNwLnZhICsgcXAtPnJl
c3Aub2Zmc2V0LA0KPiA+PiBwYXlsb2FkKTsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIC8qIGNoZWNr
IHZhZGRyIGlzIDggYnl0ZXMgYWxpZ25lZC4gKi8NCj4gPj4gK8KgwqDCoMKgwqDCoMKgIGlmICgh
ZHN0IHx8ICh1aW50cHRyX3QpZHN0ICYgNykNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIFJFU1BTVF9FUlJfTUlTQUxJR05FRF9BVE9NSUM7DQo+ID4+ICvCoMKgwqAgfQ0KPiA+
PiDCoCDCoMKgwqDCoMKgIC8qIERvIGF0b21pYyB3cml0ZSBhZnRlciBhbGwgcHJpb3Igb3BlcmF0
aW9ucyBoYXZlIGNvbXBsZXRlZCAqLw0KPiA+PiDCoMKgwqDCoMKgIHNtcF9zdG9yZV9yZWxlYXNl
KGRzdCwgc3JjKTsNCj4gPj4gQEAgLTEwMDIsMTMgKzEwMDgsMTQgQEAgc3RhdGljIGVudW0gcmVz
cF9zdGF0ZXMgcmVhZF9yZXBseShzdHJ1Y3QNCj4gPj4gcnhlX3FwICpxcCwNCj4gPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBSRVNQU1RfRVJSX1JOUjsNCj4gPj4gwqDCoMKgwqDCoCB9DQo+
ID4+IMKgIC3CoMKgwqAgZXJyID0gcnhlX21yX2NvcHkobXIsIHJlcy0+cmVhZC52YSwgcGF5bG9h
ZF9hZGRyKCZhY2tfcGt0KSwNCj4gPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBheWxv
YWQsIFJYRV9GUk9NX01SX09CSik7DQo+ID4+IC3CoMKgwqAgaWYgKG1yKQ0KPiA+PiArwqDCoMKg
IGlmIChtcikgew0KPiA+PiArwqDCoMKgwqDCoMKgwqAgZXJyID0gcnhlX21yX2NvcHkobXIsIHJl
cy0+cmVhZC52YSwgcGF5bG9hZF9hZGRyKCZhY2tfcGt0KSwNCj4gPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcGF5bG9hZCwgUlhFX0ZST01fTVJfT0JKKTsNCj4gPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHJ4ZV9wdXQobXIpOw0KPiA+PiAtwqDCoMKgIGlmIChlcnIpIHsNCj4g
Pj4gLcKgwqDCoMKgwqDCoMKgIGtmcmVlX3NrYihza2IpOw0KPiA+PiAtwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIFJFU1BTVF9FUlJfUktFWV9WSU9MQVRJT047DQo+ID4+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAoZXJyKSB7DQo+ID4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtmcmVlX3NrYihza2IpOw0K
PiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUkVTUFNUX0VSUl9SS0VZX1ZJT0xB
VElPTjsNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIH0NCj4gPj4gwqDCoMKgwqDCoCB9DQo+ID4+IMKg
IMKgwqDCoMKgwqAgaWYgKGJ0aF9wYWQoJmFja19wa3QpKSB7DQo+ID4NCg0K
