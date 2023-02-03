Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8768948F
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Feb 2023 11:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjBCKAx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Feb 2023 05:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjBCKAv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Feb 2023 05:00:51 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E172953EB
        for <linux-rdma@vger.kernel.org>; Fri,  3 Feb 2023 02:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675418449; x=1706954449;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8RZqjNcGXR9rKVmhTL9XB6fHUgM8KbFdmLVg2tviGXk=;
  b=TJ/nVljKUemWzIAJY/C8VAjo/gzKHEMA+zp6txOGXWtrNFxnHs8TUVKB
   ZVBi+JgjAmjsJuZFsPpFCFewBDu5pKLacVBeAjVtPwqlD8DQmS8hDfooI
   CSi6xciusc8c7CyAspmRqj+NHsXjFDJjWNw5YhEJnfYD/xUdVG2yg3NM5
   Qkdwvj7wbAKudAeFJagl3wK75MsfVl6WTHN5YBRPUa6f3deDDVFjyOFQ0
   3MFvZEYWq/hgppdibPKRAH0l9yEXydeJQeEYylzKwU/KwnTsPyOXClqZT
   ldLw0u15AzR4ZUJ2pjDFW94iTCyvO0a2Z7ddzcMn+DtM7EGZXNjRXsmow
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="76100786"
X-IronPort-AV: E=Sophos;i="5.97,270,1669042800"; 
   d="scan'208";a="76100786"
Received: from mail-tyzapc01lp2044.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) ([104.47.110.44])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 19:00:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc7vtSbIquUtao7f/NnkPMREAoL6GOCxIGzNmADmdThIp59ibz+VF5eArO+GWe8NL4XYlBDQllU5o9CvW332JeCSvMwlKqlqAZKtR2pp+LLwFD8gMvCrLzjhPr/0+OsdSJc7pRN9LAHwXqKFjAQhUSnyvO9MVyg86gtgpGQWq4O8kcRyghbyzHjjOzk72oX1ajwVbwXXUBmGn7VaBBmbvc8H3N4fxe0yQS6C0fXUEqGZiphv+TfjJ1L9IZ7bYyVuJl65Z5w7bEsOz1Ji7LqYqFUiflw87mxZLJDBdL74BSuwkcW3JN/EDchs1JHRBIGQpIEtrhH9z6nYnmK6EopKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RZqjNcGXR9rKVmhTL9XB6fHUgM8KbFdmLVg2tviGXk=;
 b=izdh3dnfb2rPVGw58LHO2wbopBnXRLu58rl+mW1sLZHXaCwUjDkKZQZW2zaTbUDoU8AiIdSsMPvex+ffkceFg2qn+T5lk8lNFPQKcYr5rz7NfYwUXe2Zkd+wKrPdbDz8OKyfdfMDVQ4GqIZSIIne59m3pE/tIP3jR0CCk0G63qDJmW4FTk9Hr4RqedP5Tu3SKyPgmcytlfwgf/eoJnlp1wkiY0gykVx2JNpYRkupEUXVIupixxq2LOA2+vzMZyFeAcwNUXRjDZwCjyn4vQLcq8zVPbi43D7xYg/ggBNFkHGNgC4i5w8HpeFj0WaXJgYSAx1CV+n8KPg6XscvfOZ/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYCPR01MB8755.jpnprd01.prod.outlook.com (2603:1096:400:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Fri, 3 Feb
 2023 10:00:43 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::bb20:2461:b1ee:e8c4]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::bb20:2461:b1ee:e8c4%8]) with mapi id 15.20.6064.025; Fri, 3 Feb 2023
 10:00:43 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Thread-Topic: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Thread-Index: AQHZNsEksOa6eDMa4k2zkvGhx4F3Za688xXQ
Date:   Fri, 3 Feb 2023 10:00:43 +0000
Message-ID: <TYCPR01MB84555DAEE984472F7B209B80E5D79@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20230202044240.6304-1-rpearsonhpe@gmail.com>
In-Reply-To: <20230202044240.6304-1-rpearsonhpe@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: eef5a4fe6d424c7f898ee9a9d39ede31
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDItMDNUMDk6Mzc6?=
 =?utf-8?B?MzhaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1iOTIwZmM3Zi1mNmEzLTRkNmYt?=
 =?utf-8?B?OGRkYS1mNzI3M2JjNTU4OGQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYCPR01MB8755:EE_
x-ms-office365-filtering-correlation-id: 7a9638f1-8e9d-42cf-55e5-08db05cd833f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWN9kMxC48o64YG5Cp4nQwYT3FdgKiycBgXnyer8vgAZ91ADIBn5tyC5x03BcDCIQHGXUtcXqzsJgtMSwpVVmk+IjZWBvrae8teo8BigIab8v/wCdJTm94lYontp8cG0WEGDK06oc52N7Y7qc/4NAnOq5g7XnZG328ZUiOLMaGbHoWM32C3mLyaqlY3EcBsAKhpJCPj7Oy7Igmp/7z5U9Dpkls8t9fM9hL6JAmC4rgaVf+J+9FXKxQRclaVpvifiBkQkul5JRmdEqcc2b/wxJLfGCClu9iRPIV1f/INAZBPF2Cilr0vk7CCOmC6QPHe55PZK/0n+IxuIpqaF05TXS4Y7Xh0A+WWYu68hkUDHd0TVlPLmNN67NVA2c8AwGcz2ZV6B+vfoaYmOUyoUB2yrxHNYV0QDTPI0yQTGv+wUM6cN3rFd36eLIVRJ45Rw2JXlOJaV/YSamwkxC10tjcCnLG4Anrgx93biBJ6+Yr8+/dHQKNNhnUsqPcAwN5QJ4JmDuZbx1F9a5zdckqrlkNDxajH1RVkP98NadHtNelV9bYA3/UEhzY3x4wV2pZtc6LAiPL8phjZu/OfKkQWbLgDAFkGrVnKeWKbQUhMQ1c8pjasXxxBK+OwShMJ0wKJcBCLZucn9BXpdRnEwbjKjWyVeO4/i6SFpaEQT4xoDPiTdt0wYQi9uGodcI4i9D0DpkeOH21EuK4svi89OAocyFPRii1EsjvhvRb9gFb5lqV+WlgQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(1590799015)(451199018)(33656002)(26005)(186003)(86362001)(6506007)(53546011)(9686003)(478600001)(2906002)(71200400001)(7696005)(316002)(122000001)(38070700005)(110136005)(1580799012)(55016003)(8936002)(66476007)(85182001)(66556008)(66446008)(66946007)(64756008)(8676002)(83380400001)(76116006)(41300700001)(38100700002)(5660300002)(52536014)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFJvelRxUmFqT1dUL1BpNVdsSzJwZkR1QXZYM1lOWEJsd1JTY1EyY3VpWUFD?=
 =?utf-8?B?QzNGbmN2Z0ZBaFRCTG56NldSeVJqZUFTeFpiSVVSRERCeGUyN1Q4ek5XZW9k?=
 =?utf-8?B?SFlpaEZmMXZXVVBPdlFhNy9uelBib3pvZDB4WC9MSytxSlRmeUVzSStyRUVI?=
 =?utf-8?B?Vlg5czc0ZVV0M0dBb1BMdFNqT2kvTkJBclRic21SZEh0OWpLaWhYejVMT3dR?=
 =?utf-8?B?YTFGaEcvWEJyS3dJNmc1UHFKNHVXZTdOV3Z1MlhBUC83a0MxMGpTMzQxdHY0?=
 =?utf-8?B?aXd1dXBwZ2Y5USt5OUZPVkpld3FGNnZSS3FPUjUyUFJSWTV1OXNaMEI2bm92?=
 =?utf-8?B?SGNUVFN6NDRyR2EwVVA4elVwLzN6S0o3b1lESDB0Q1IvRmZ0dTNCNDBDNHVq?=
 =?utf-8?B?OE0rNjJZSitHK1ptNUdld1o3MVZJZE1KczdCZjhhdE5XMnBGUzliNU1hWEov?=
 =?utf-8?B?cmh5Vmp2MllCTlAzemRzMWFJc002Y1BEZnZ5c2xrOEZmZGkxRTdJU3dHZis3?=
 =?utf-8?B?K29wSDJHd0xWU2ZjR3k0bE5tUkVJTjdDbUpZbFVIbGo0aWZjeWNiMlljUTdD?=
 =?utf-8?B?YUVRc0ZqaUpNZWNQa0ZqVk9NaWM4RVdZUWNaZURpOE9lTktoTGhaaVdwRmli?=
 =?utf-8?B?ZGFRK3FTQnZQSHRlY25EZlcyZDl0RXFkOWNWdzhkTE5BWGlPdzVhbEJ5enpu?=
 =?utf-8?B?WDNFMXpZaE9BTi9hTFJyVTJ4c2F4TWdCSjBiRnIrUStWbnpsK3BNSkFJOEty?=
 =?utf-8?B?Wi9iaDRzRmV5Q0c3OWswNm81SkdXZm5DbUZrMFBKOXF5UDROaHFKenhTc05E?=
 =?utf-8?B?ZlVva2QwVC9iU3RaUFExcDRQeW9JY2V2cGM5aDh1Ly8vUjhWUWZoYkdzeHlF?=
 =?utf-8?B?RVJaQ05YVXlpUFpzY3VSdUV0STNyQ3NHYWZ5U2xGdUwxaUI1b3ZIRnpocXlB?=
 =?utf-8?B?aURvSTZPK3A2bW0yQ0VBb0dzWnU4Wktyd0pscDVYa0lNcVcwYUtVTG1jckdp?=
 =?utf-8?B?Nk5lWnNHbllWZWVzSWhIb3Y2bU9aOUNaWWUrRkNvaWxqUFdMY2JMV0ozdGNp?=
 =?utf-8?B?aWVMaGVSSHUwaWEzakVnQnBodzQxTThCUVloamVZT21ZR2FNZEJ2dFZ6aDBk?=
 =?utf-8?B?QXZxdVN0aWQ5eUVra1NuWWovbWd2ZzErMjZDWStLZ3gwUWREOHJLcU82dTJi?=
 =?utf-8?B?TGNURXFCbnZmZk9uc2hjQ1NOY1JaV2NIWHFkK1c2NXdzUlloelRYNzFsZjd3?=
 =?utf-8?B?YzNKK3VzazlHdC9HdFIwUWxMTW5yRlVtaGx3YStTZzBveENBTEJQMTlibHNP?=
 =?utf-8?B?L2I3NlB0WDZrMkdhaWtncWlsQ0FkUzhMVDNKVU1lSFdQVjJON0JBakJ6Qk9j?=
 =?utf-8?B?S1NxcEhuV3VLZ2p6Q25KMjRQR3hjcDBVb0RLUmRZWkpOVm1MampDbW5LWlA3?=
 =?utf-8?B?SlpaQzNONUowVWZRZ0p0UVBlUXlvRFhyVmFhR3F3OGtFamw2VStwMk82VWx2?=
 =?utf-8?B?RUtKbXBhM2ZMVGRzZEVEeXNhQUUyNHVITnQyTkNzUUt0QnV5QS9rTnAyZkZH?=
 =?utf-8?B?T3hldGFCeER3NlZya1htZncxSklJL0xlMzVROFMzckZkYTJsa3NUVnpvdHkx?=
 =?utf-8?B?bEM5VVJaY0ZOREtHYzBoS1VZU3AvMGZ0UndSRE5LUWNQKzQ3eG5tbzByeVVy?=
 =?utf-8?B?UVVTQkJJQVRMZWZxYlBGd1BUbHB1ZDJHc0k3RU1sWUh6WkY1NGlFWGcxOEVi?=
 =?utf-8?B?eXl3d2drN2xabEpnUzc2S1VodUNVby9DalRLM1U4Wm0xSXlpcGdnMFVUbjJi?=
 =?utf-8?B?QjBROE5WWjA3bVVlcnNCVU9qaC9pdElNcnhwOWFkdWZTdGlnQ0ExMlJkTzFu?=
 =?utf-8?B?cm0zOUFVTU5GN0xqN2t3aW1sa2pnZUQvUFpNaTFuMFJ6bEJqQ2M2Zk1XY1Rq?=
 =?utf-8?B?cWRJS2JCTUtNOXNwZHFhaVBIVCs0VFhHc0NScDdMZ3RvNUhkR3RyRUJNYmdr?=
 =?utf-8?B?MCtpYlcyQ1JuRHB5ZjcvOHJybHhkWWM0d3MyRVd5VkphakkxZXZES0pIcmVB?=
 =?utf-8?B?cUk0VEhKcmJWVnk4UEl1Ylk2cVF1NzVuQVJEbXNhL1p0c2pYWEhWUjdjQnJK?=
 =?utf-8?B?NUhhTkhjRjVDVTBYaUUvSHBoK0xaRkxwell2Z3N1aFo5aTlXYnkzeWYvUTE5?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W5zNJUWvsuWWazFL/CmIocGdSRsBSqWtz/oPlafWz04jbof1m1IAw9kuP9bPFJ3q52lCJtqSl33np2w4F3rAGnknG2AuF1MnmMDX8uKdeQ8yW+Sl9Ccl5hwDiCFv95to5p7i8psjpwcTsk444iqybZ8sM5aT593yg5JQbTqJhnrt0y/yZXrJnB8iO/eJw7IMmOP7s0F32eHiz/OWDWs5QtIfD2uKQCVbQBfyqtN8CXDmVwIz7dWgfRHYgIxzS5EAQ2mxJmd6wISbnGGFb7NVauBCs82fS5RM+X7SXiAelwDMATZ7cr5tEdteal+PMauMI+jdFzL2wfVcpjK6XlOhzni3XPE4OHFOWMVsk3LcoEklE8wB5Df9ugx6DZRb8nF3xiqBcqqrrfMwhD2nKyZwG7l/jIghWVpaJrMiHXHmyF3E/2BvWPmb0XRHv1RbM1AD9NunM2tA/WBR9JvAPagx8cGdoXjEpDe0lzKCMdJsZAX0+w7GDjeObxcphenIiAA1yFP35PmV9oSACeUNMIcNKfQCP3bK4Sz0fjxC2pSmZ6+GvxsIbZSyc+QdnFNQLV9PHbXC3PeaQYXD2KKLmERd0BPzoPqOk4DkFzktNBYZ9DKORz86bCUUwpzmylCSPxEaUVfLGFQWAvWt77ogIe6Gt+mNYVoqyvwLCGvCzD5K++QEyRwmXXGM50rcWM2QvkwbghmXbeWhZZAzmH7QDfrDEzToNSYDsBphnauflKAQvAnBNWpg37CC5b90APnuJ+CuKI5um6fk7PemytOGmHK6okHvaEhhR56DNcWS6Y+5DOlfmBeJ0BkkBnxPNBfvv9bH3DTrv/XoEwMf8hjqdvSZN29ltPJANTgNY0diFbh2MmY=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9638f1-8e9d-42cf-55e5-08db05cd833f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 10:00:43.1144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvaoUDlQR+qGCqD6lI1PpR2SMt0TaXYv//BKK4DdyegRnw8etuU6WV8ZiW5CPXfyTH/TNy5Noq9vvYHELn/xz2xrLGATDUdNec+GTWj+4aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8755
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVGh1LCBGZWIgMiwgMjAyMyAxOjQzIFBNIEJvYiBQZWFyc29uIHdyb3RlOg0KPiANCj4gQ3Vy
cmVudGx5IHRoZSByeGUgZHJpdmVyIGRvZXMgbm90IGhhbmRsZSBhbGwgY2FzZXMgb2YgemVybyBs
ZW5ndGgNCj4gcmRtYSBvcGVyYXRpb25zIGNvcnJlY3RseS4gVGhlIGNsaWVudCBkb2VzIG5vdCBo
YXZlIHRvIHByb3ZpZGUgYW4NCj4gcmtleSBmb3IgemVybyBsZW5ndGggUkRNQSByZWFkIG9yIHdy
aXRlIG9wZXJhdGlvbnMgc28gdGhlIHJrZXkNCj4gcHJvdmlkZWQgbWF5IGJlIGludmFsaWQgYW5k
IHNob3VsZCBub3QgYmUgdXNlZCB0byBsb29rdXAgYW4gbXIuDQo+IA0KPiBUaGlzIHBhdGNoIGNv
cnJlY3RzIHRoZSBkcml2ZXIgdG8gaWdub3JlIHRoZSBwcm92aWRlZCBya2V5IGlmIHRoZQ0KPiBy
ZXRoIGxlbmd0aCBpcyB6ZXJvIGZvciByZWFkIG9yIHdyaXRlIG9wZXJhdGlvbnMgYW5kIG1ha2Ug
c3VyZSB0bw0KPiBzZXQgdGhlIG1yIHRvIE5VTEwuIEluIHJlYWRfcmVwbHkoKSBpZiBsZW5ndGgg
aXMgemVybyByeGVfcmVjaGVja19tcigpDQo+IGlzIG5vdCBjYWxsZWQuIFdhcm5pbmdzIGFyZSBh
ZGRlZCBpbiB0aGUgcm91dGluZXMgaW4gcnhlX21yLmMgdG8NCj4gY2F0Y2ggTlVMTCBNUnMgd2hl
biB0aGUgbGVuZ3RoIGlzIG5vbi16ZXJvLg0KPiANCg0KPC4uLj4NCg0KPiBAQCAtNDMyLDYgKzQz
NSwxMCBAQCBpbnQgcnhlX2ZsdXNoX3BtZW1faW92YShzdHJ1Y3QgcnhlX21yICptciwgdTY0IGlv
dmEsIHVuc2lnbmVkIGludCBsZW5ndGgpDQo+ICAJaW50IGVycjsNCj4gIAl1OCAqdmE7DQo+IA0K
PiArCS8qIG1yIG11c3QgYmUgdmFsaWQgZXZlbiBpZiBsZW5ndGggaXMgemVybyAqLw0KPiArCWlm
IChXQVJOX09OKCFtcikpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KDQpJZiAnbXInIGlzIE5VTEws
IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBjYW4gb2NjdXIgaW4gcHJvY2Vzc19mbHVzaCgpDQpi
ZWZvcmUgcmVhY2hpbmcgaGVyZS4gSXNuJ3QgaXQgYmV0dGVyIHRvIGRvIHRoZSBjaGVjayBpbiBw
cm9jZXNzX2ZsdXNoKCk/DQoNCj4gKw0KPiAgCWlmIChsZW5ndGggPT0gMCkNCj4gIAkJcmV0dXJu
IDA7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVz
cC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+IGluZGV4IGNjY2Y3
YzZjMjFlOS4uYzhlN2I0Y2E0NTZiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQv
c3cvcnhlL3J4ZV9yZXNwLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
cmVzcC5jDQo+IEBAIC00MjAsMTMgKzQyMCwyMyBAQCBzdGF0aWMgZW51bSByZXNwX3N0YXRlcyBy
eGVfcmVzcF9jaGVja19sZW5ndGgoc3RydWN0IHJ4ZV9xcCAqcXAsDQo+ICAJcmV0dXJuIFJFU1BT
VF9DSEtfUktFWTsNCj4gIH0NCj4gDQo+ICsvKiBpZiB0aGUgcmV0aCBsZW5ndGggZmllbGQgaXMg
emVybyB3ZSBjYW4gYXNzdW1lIG5vdGhpbmcNCj4gKyAqIGFib3V0IHRoZSBya2V5IHZhbHVlIGFu
ZCBzaG91bGQgbm90IHZhbGlkYXRlIG9yIHVzZSBpdC4NCj4gKyAqIEluc3RlYWQgc2V0IHFwLT5y
ZXNwLnJrZXkgdG8gMCB3aGljaCBpcyBhbiBpbnZhbGlkIHJrZXkNCj4gKyAqIHZhbHVlIHNpbmNl
IHRoZSBtaW5pbXVtIGluZGV4IHBhcnQgaXMgMS4NCj4gKyAqLw0KPiAgc3RhdGljIHZvaWQgcXBf
cmVzcF9mcm9tX3JldGgoc3RydWN0IHJ4ZV9xcCAqcXAsIHN0cnVjdCByeGVfcGt0X2luZm8gKnBr
dCkNCj4gIHsNCj4gKwl1bnNpZ25lZCBpbnQgbGVuZ3RoID0gcmV0aF9sZW4ocGt0KTsNCj4gKw0K
PiAgCXFwLT5yZXNwLnZhID0gcmV0aF92YShwa3QpOw0KPiAgCXFwLT5yZXNwLm9mZnNldCA9IDA7
DQo+IC0JcXAtPnJlc3AucmtleSA9IHJldGhfcmtleShwa3QpOw0KPiAtCXFwLT5yZXNwLnJlc2lk
ID0gcmV0aF9sZW4ocGt0KTsNCj4gLQlxcC0+cmVzcC5sZW5ndGggPSByZXRoX2xlbihwa3QpOw0K
PiArCXFwLT5yZXNwLnJlc2lkID0gbGVuZ3RoOw0KPiArCXFwLT5yZXNwLmxlbmd0aCA9IGxlbmd0
aDsNCg0KQXMgeW91IGtub3csIHRoZSBjb21tZW50IGFib3ZlIHRoaXMgZnVuY3Rpb24gaXMgYXBw
bGljYWJsZSBvbmx5DQp0byBSRE1BIFJlYWQgYW5kIFdyaXRlLiBXaGF0IGRvIHlvdSBzYXkgdG8g
bWVudGlvbmluZyBGTFVTSA0KaGVyZSByYXRoZXIgdGhhbiBhdCB0aGUgb25lIGluIHJ4ZV9mbHVz
aF9wbWVtX2lvdmEoKS4NCg0KVGhhbmtzLA0KRGFpc3VrZQ0KDQo+ICsJaWYgKHBrdC0+bWFzayAm
IFJYRV9SRUFEX09SX1dSSVRFX01BU0sgJiYgbGVuZ3RoID09IDApDQo+ICsJCXFwLT5yZXNwLnJr
ZXkgPSAwOw0KPiArCWVsc2UNCj4gKwkJcXAtPnJlc3AucmtleSA9IHJldGhfcmtleShwa3QpOw0K
PiAgfQ0KPiANCg0KPC4uLj4NCg0K
