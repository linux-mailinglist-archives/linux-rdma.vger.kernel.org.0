Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40B342EFD0
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Oct 2021 13:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhJOLll (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 07:41:41 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:52035 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233155AbhJOLll (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Oct 2021 07:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634297973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bJ3ln5Wu8vWITOR475jV9Ncp8Zc6xquMjlGdH8Nngps=;
        b=AxEOX2jg1E6PulbRVlBUTD5l2ppvRatdFuzLXDCEYEFwpRvcgPMKtzbig91h/vU4xRb8Cb
        b6f3kO9UKEU+Gzq4H9NOxCKIRgb4NN96ixaBzzrENLi3fcwX4WhYlQhVwvln+9GUxvQ+kF
        5ZxzauH+1fiyvZLnWk0/kdIAZPFC6I8=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-36-FTz10IlgOm2fl0NDv_aSnw-1; Fri, 15 Oct 2021 13:39:33 +0200
X-MC-Unique: FTz10IlgOm2fl0NDv_aSnw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFVEcAFVKg0zHiEmbvFWEGpdg9NcEx6wLWzsJ6gf0GqPeJzB31P3c4WNqTIwajKC6j7cp6luINuX2nUi1/399OQotVEqkQOg66T7nSfPsp9O4TtiE42MJrKTM4T1ASPoKua/5j2WTbUSCDK6ydooaa+v1jrCknRvc80Ftlquy7YJeY4yc3S7kTB6ixDYifk7/XAiZ3RcSfOuh2aB1RG1Cz1Juc8d7B+mOrescyeTeVT8GYfqLUlJPm785/l6k+Y5p5nGdZTHUQfF/MODCHFOQ9GDOkfK3A6HAnZgWEufb5AQa1X7FrQW5Bj+lIigBxsq9oiMN92zXDGuxMgpPICuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJ3ln5Wu8vWITOR475jV9Ncp8Zc6xquMjlGdH8Nngps=;
 b=cfvTryN+mdbS6cyRVMaPqPKpz6qPStkRKkC/FDstwzDS/0vsg5IjFZ698UgBuYo/TzwR+FfE8bQItsN8HrkIE70gbk1MTcwfG7liz+maziY30lZEcw0U4xJmdARuJLOVTh4XXAHh2s3NK3pnEsv4jIG3wFSougJjobA0rjvURiGdUUMacfydZwQEq9yV8zwCtGy0triuS95lIriPwWFxn8jS9I1a8ASYCalqrCKBPYMBCU1LaGx4NDivHY5fNm6X91GVnM95mkkMUZq2lglW0fk5AEVdLF1A12TPnuaknqT6tIcp7eYY61Tu7gpMGmIEf2pKPQZWBpEMeaM/E4G2JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB7PR04MB4378.eurprd04.prod.outlook.com (2603:10a6:5:30::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Fri, 15 Oct
 2021 11:39:31 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::cdcf:9094:49c2:8a2f]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::cdcf:9094:49c2:8a2f%8]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 11:39:31 +0000
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [ANNOUNCE] rdma-core: new stable releases
To:     linux-rdma@vger.kernel.org
Message-ID: <614fce14-b5c9-05c8-8cb8-f38b523b933d@suse.com>
Date:   Fri, 15 Oct 2021 13:39:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MRXP264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::23) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
Received: from [10.0.2.127] (86.200.129.241) by MRXP264CA0035.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 11:39:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff80320-ee48-4bb4-4113-08d98fd0740a
X-MS-TrafficTypeDiagnostic: DB7PR04MB4378:
X-Microsoft-Antispam-PRVS: <DB7PR04MB4378E66B187572AC99C77E93BFB99@DB7PR04MB4378.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8O/Zxq2Mb7qE+OmkyQFoucts5Iw8nzJHkFZY96gSgnVpHmnQxVI9b1av0zVP7JuqckPx8OLFiOXE3bD2uOLoWh3qfzQInAJ0yN0bXlWkHAcw3Ec6pltNwe2zV7WUTC6BVLk5JgCksWwl8bdqs2DscggjjbcfR7PZYVpLxyicnU5PITFwfsQ0WsbiWave90w1L6j6zlmVqqkSPLScejgR88iYPOAHUFrxAhrz+DthdHhCnAo7Fhl/rgXWjUZEemCJr/W1Dn/9uueSCLSKJngG/R+V4PRw1TDENEn94nVUeElzLtkCfiq5Q6duQ1I3J7A6GSleFqE0muRhq7am1wfHFc+jvpZWM0hxZk80ajqamdIsfFbKcYdIE9Sh1tY5qnfudbrD1mb/lBNFcEXIKNgzJRgu3fDpRWJZbd/FiEpYHO/eimP8YdStLAGTnKO9KU7ao4GQPtb5xkLcLY7kqYGZcTEiytcYEO1gqtG9r9Yn41ZuRT2bONPtlceKcqQQRk2PFVTONSDqTA0PNcoT2HdNFnkGcmdSwyMHVY88rKj3cpCzhplEfYlN8xrarjiPdC3AyRcCglFVDVakBM7uPJ/6wvMyxgHnPemaJWbKoUhJZ1DfwoJCpR+gb3M7hLYgQ4VjgLhBzzuI+fClmEtSpgpO5YgWaKo3T7oQUeynVxuEpGnCTCY0F1mSMDzFGtP+ePIs8/5QF554gYYYU7WruzshJQE5G2eDqEi/8F8Bd8+djUfJnQLX5ScPp65JemR0liME4sr71LURrzJYQUqrfBXOql5JKhZY81206wTQpbG9OOunSQIRGP61LHvTk1w4bOe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(31686004)(8676002)(31696002)(66476007)(66556008)(66946007)(316002)(16576012)(956004)(5660300002)(2616005)(2906002)(86362001)(26005)(30864003)(6916009)(186003)(38100700002)(508600001)(36756003)(83380400001)(6486002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVp2eVJWTXh5bzMyN0NMaER4WWZMQkNoNHQrZTZsdU85OWs3YzhPSUlkelYr?=
 =?utf-8?B?Vnk4cWR1RDVOWEpnamRLaWVtTS9pNG1FWDVIWkN4RVArZUJRQzRHQjM2YmIz?=
 =?utf-8?B?TFUvNXU1LzI0WjhFTGREcVFSYTZIdTRNalkvUW8wTE5ZLzJYbjBLMENTRGRL?=
 =?utf-8?B?bXpnTG9PcHFIYk5kZVJHNXhSN1ArQ2VKWXJKc2hrb3B1aGE2cEpXL2dPenpX?=
 =?utf-8?B?MmdDbjl4dDdJQjJLek02OTRiMFllMVA5QllLd2ZmVGtEVXhIci9wNVZEZTVV?=
 =?utf-8?B?VjVYUWdLTFNTTlpDODVVQnBpM1BOenJNT25vTnQzaU5qVHZMUlU0N1JybDE4?=
 =?utf-8?B?YWEvSndIS0x3djFIVDVNSElSTXBQdFBvNzJEM243dGsyRm5lbGR1N011am4z?=
 =?utf-8?B?bDRNMVlvRGRVQnFHLzFFRlhsWlBjTUxDQXVKaXZRQkRraTI4ZEZhZUZERXJz?=
 =?utf-8?B?b1ltTzNKVEUrNWVTK1dDUjA2WkdwQk5RVmVYU0dCRkczeDNweHU1aWg3aDls?=
 =?utf-8?B?Z3RobUFsdld0U05tR3dDWUNNVnE5TEQ3dXFCMmlLellKczBjQS9MeFRhNEYz?=
 =?utf-8?B?TnZYZDVIME1EWnZpQmVYL096aUt0cm0xYjZHQW9pRVYzU3ViWlg1TytsdUN6?=
 =?utf-8?B?Z2xIYXVQRHp6N3ArMWtJeGhjaStNdUNDUy9hWmxRUkNFNUk2d3pTbmhzUS9Y?=
 =?utf-8?B?RGFFaGFUV0t2REVvWW1KcXFydFlyTXhWRnUwVFl2UFdKeTNmQ241Z1F5UmZL?=
 =?utf-8?B?M3VORFAvS01lSFVqMEJlZWs4eHJWQi8zM0JaK3JlYTFnSXB4d3B2OGowdzBY?=
 =?utf-8?B?bHdLWmZ5S3VzOUljNHEwR3lha205T3haQzBMbGdnZ0Q2RGsrb3VVcUw5QWY0?=
 =?utf-8?B?My9naFpXUHRrTDZpdlNRb3hjY2dvMno4UzBWdU9VcEFBQi9pajc2K0pWdi9O?=
 =?utf-8?B?a3NIWG5La2p3ZHF1YjR0cmRVc0lzNnhoS3ZWa0FGQldRU0sxejdTVTdtSUVU?=
 =?utf-8?B?V290bElaUlU4UnlVZ0FFd0dMNjFROUNtZWVzeXVSSzdPbHMrWEpGZ3F0RURh?=
 =?utf-8?B?bDIxSUFNTUxMeWVuS3lwenRWeG1DaE4rN0FUY25ORko1YzNCKy85Vmw1RzdZ?=
 =?utf-8?B?OEtzU3hYT3dkcHRpTGdRTGREQnR1UE9HS29PYjR5dnlQWmh4N1E3RWJKeTdu?=
 =?utf-8?B?WFBYb21sRXIwVGpnQ04zd0d6c3RXQWxuUm5HWTk1MDdpK1pqYS8wRVNLN0RW?=
 =?utf-8?B?TnBpcDE1WFI3Q2x3Z3JYaUg5aUlxYnBVaXZseG9zSloxeFVBMzFFamNrZ2ds?=
 =?utf-8?B?M2xMQldQZ2s4U0NxekJvYVk2eTY5TTV0bGtrSDU1M1RMRzJRZ2tkOTBQSkxs?=
 =?utf-8?B?aThyb3A0L3JORmUrYmFiWTFTdmRQdVJSQXNJU25WWXB1VXNXaUVGdXo4bVhv?=
 =?utf-8?B?Z2w4M1JaNlQyeU12cGtWTjVjRXA0M3B1UWJzVWZ6K0hsY0JMdHVHQno3OTI5?=
 =?utf-8?B?S2dJcWtwYmNXSFU2cFRzd3YxdzNvWURyMjRtVjBDelZTOGlHZ0lpOFBaenVN?=
 =?utf-8?B?MVk1VGx1b3NucjVnN0E4cmVDMSs4OVE3VnFCQmg5RzQvdlZFVTZ1QW8vWng1?=
 =?utf-8?B?eHdvTFluWFZhU2tYdXdwQnVINUFGNHZRV20rVTJNcXo3eTlIZjMwc0VRUFFB?=
 =?utf-8?B?WEtBeDN4ejFpY1NQTzIxN2w1RlNMNWYxeVo5WTZ4bDlLZ0hmMHdGam1jNm42?=
 =?utf-8?Q?jsLmiU8v/Ry4d8FK3HVqMXXZ+iP6Lpd6CBSA/Fd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff80320-ee48-4bb4-4113-08d98fd0740a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 11:39:31.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jscjesCc0ZSPSjIu2mT7c+srRhOyzpaAw59nQkvCDg7xAKyqbNXNMBEzvDZMXJJfB3xClm0abac9oLsxXskyVGZ4B0Zo+U/NvuqQ0/hpIF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4378
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These version were tagged/released:
 * v24.7
 * v25.8
 * v26.6
 * v27.5
 * v28.5
 * v29.4
 * v30.4
 * v31.5
 * v32.3
 * v33.3
 * v34.2
 * v35.1
 * v36.1
 * v37.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v24.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:11:15 2021 +0200

rdma-core-24.7:

Updates from version 24.6
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * mlx5: DR, Fix error flow in rehash process
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRbUcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZOzMB/4yv/Tfe0JsUF1EFFm3
H3gyPbBFQFkhpMHOUCK5MR0ID6Uq3I0wByaEzAOkET9NuU0t2pVttmg2PReFQq9E
hb9Hz0YoyvJrhTTdb75LAAaJmBa8kH64NFTc1MlAloq0/yHQcGj9B8XzwEmVGdQ+
iYowFWEB9EkCwz0uZieUSRqbhO7Wmb4km4hNY9R7lABmIHYbod3jbzgMgvT/WiS9
zvpUUI7/pzlZ3gbjX8DUbBF12rsdVjHkqDeMw7moUmN5rJeQqFESWKl0H16DNmBa
JLyfuUGiKe1BZx1w7tLWlspxo6669j4TYJ5yLPU/TW9c+oTlVovOkRtB24AV4Kp7
lMby
=TQKA
-----END PGP SIGNATURE-----

tag v25.8
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:11:22 2021 +0200

rdma-core-25.8:

Updates from version 25.7
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * ibdiags: Make escape character tack effect
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * mlx5: DR, Fix error flow in rehash process
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRbwcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZGSVCACcliRArIuwPF7rr97g
qSPpgP2NgIN+ZQrT2uhFuKoLCC5fHE36TjlO1fDpDcIhG/0GRMH67Z7BoG7z+HlW
Gq2PsxSpRMkFzpsQK5bXogmMefWzUTdJ2oXKO9jrGm9YzBZuGRMTLCiKKVPki/eE
9cWbbhMHpPEUHeo0ds+VQmty3SpLstCdbqraDI6nGHkOAkER+SusQo1d+8iEn6n6
xlXLBEyj123vOYmSl2DA3f5a94ByRui8EBeOmXbF9XNIVYrClxSL9zYgPlYTgS6Q
OpXWrm8vB1v1ISK+QpgiBg1Rd+Th1NJ/jEmBIqDmThFeu0FlA2060cQ0IXrnxULo
7RXU
=s72u
-----END PGP SIGNATURE-----

tag v26.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:11:27 2021 +0200

rdma-core-26.6:

Updates from version 26.5
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * ibdiags: Make escape character tack effect
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * mlx5: DR, Fix error flow in rehash process
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRcAcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZIkFB/wLK7+gLvOjjHKv5jcb
SlIVC8frhUxwTEu0qxDlikDUF0+v++bR+DBtaiOMqyPZyjS0gziivxiRFlV0kWZI
Z4x7EgiF4QLd+IpCZAapZ2jsEBD0Gm8dO/9GcrLSUG9MmJsdrjeYd+6m9+Tg0vrS
ofqyB4LU6lxerLeIypvd2xLCDJH+aajyO7NRf4NPebz68uzK6qEviFv3uIqZd5kZ
QIG1T/i7v59VkdNO/Qgwc2BI/WTw3cmz5kB4E6oaT8A9U6AAoXVKkfu8cSXUHJuw
hcolshNkMNbG6fsgTmFgvUKOaeiC8mT+KuWd1wnRvNF0ZvwC8v6P4cei+lr1UR05
Nfu4
=HXqQ
-----END PGP SIGNATURE-----

tag v27.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:11:31 2021 +0200

rdma-core-27.5:

Updates from version 27.4
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * ibdiags: Make escape character tack effect
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * mlx5: DR, Fix error flow in rehash process
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRcUcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZH18B/9FitgOnF6AJBaITmvp
J3Qh4K6lJECr0Onccrxk6jN3agOS2KoijZyfFbf3cbPn+z/keD9M8pkSBrqb5P+6
JdfdLRnbtFNyD3kyBOE965SEtCNXo2f5UzbPqwmZz47lOo9FnXMoJqsJzbCgynCu
dOjCTSBehyWpPEMIY1MAFn4mllG19Od1WI7lyceMHWmRJLtbW/AuZ1EFQ51C9XT2
+3vzxjf5aXXbaooUspMxUROpZ1PYntxUiKQpXZodBe7LEcbgrMg4JoLczwUiHKZS
H7IDl3kpY06vy5OePzI/fCAUYML1qzlV7fwFnC5mJj+56XMUg00ioibuSZD65E+9
NeYt
=IeRY
-----END PGP SIGNATURE-----

tag v28.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:11:36 2021 +0200

rdma-core-28.5:

Updates from version 28.4
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * ibdiags: Make escape character tack effect
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * mlx5: DR, Fix error flow in rehash process
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRckcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZABaB/oCACmoc+8LDUTZGdsN
rIG5/yBCCwYJCmRBPk59yWrMxZhO5xSRIRpSBAKIrkN14FDDBTARK/ilVgyNd9Aw
XVvpIAcrV9u+oC4GZKnByTH3oNsmAjGMTpqIaoJq94hbzKAghitYprw1aiTH8juc
5Q+QNBsaUjDJ7cvPFAGRrex3R09qaRWrlxtH3DIPB2K0XM4/LYjw0OTqhimi7UdZ
9hQkxqkRV8tGk3vg0EAn1f/AJTkhZ4a8Abhn2dQpfYvTh09ruGlBrNn9nxt0G0nu
Sl2X+uZtqBZ+So1OGZWtRXpwuXYj8LmAmvpMi1SSiOzEdJpr36SJVvYgtA6tb2xa
HF/j
=tBWz
-----END PGP SIGNATURE-----

tag v29.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:11:40 2021 +0200

rdma-core-29.4:

Updates from version 29.3
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * ibdiags: Make escape character tack effect
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * tests: Make sure that end_poll() is always called
   * mlx5: DR, Fix error flow in rehash process
   * tests: Fix QP extended MW bind test
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRc4cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZMyuCAC+QYNl5DI9clC4AxS9
1GLq+nQqcVyVOa3MwIR1NcDzaoDRUn1fO9+NsyHjgsFUfZwsb2h8wxQdVbskSILC
WdrJQkQBZZz1mDoiDwS92OG8XiNZdweBn2mo297eXjBFVcxZBY88ubq3bAsx4aLI
3yBRbIKyAo0uV8/8jyS1kh4UTWuQQYUCUXQXQdYM23lV8yKY7JIdwT3geQ4J46wb
2pYEKAf8ydSOsJCy4ME+UahDK7FZcf6jXcaKLnvP58VzloR6uQoHAKEKD9cisfMW
ZObbFdb02XbvxgaFxGf4gIzZ1sYpd4LDdV1qfXE9+SBVbQplYO95vcU4KaIxI1bO
p5A8
=4KaH
-----END PGP SIGNATURE-----

tag v30.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:11:45 2021 +0200

rdma-core-30.4:

Updates from version 30.3
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * ibdiags: Make escape character tack effect
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * tests: Make sure that end_poll() is always called
   * mlx5: DR, Fix error flow in rehash process
   * mlx5: DR, Fix DM allocation when the size is not aligned
   * tests: Fix QP extended MW bind test
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRdIcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZLCEB/sE73l8LIvyY1/qQUPS
F1BhZRuMCb3jtoaT82QZMyCNrtWo1TGM7jgxG1/SJ//6qHFuRw90qjKlkeGs/9Ks
7RR6luK6yHcCB4+qFyeO90D7FhXdW6hURULdkyb3Nnw7qcgx1ZJIdVkVzCcBxRBL
/0ZHdYZH8yPOM/BK5zFUEF3QKKQvPchnCdQD/v9OttlphU7Pnpe0H4LRf7CVLUZx
SdDeXTRdFP9bgrhO9qA6hKTeNXLIzH7XXvVf1hPrpIWmiySo44hQAD7FMEtrvW0c
oMuXHThj6YGiTaC0d6UJ80sB4zoiFiF67dq3eHSDgam42jHOqdVbHMk4rsxmPnbj
Yhv9
=BKZG
-----END PGP SIGNATURE-----

tag v31.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:11:48 2021 +0200

rdma-core-31.5:

Updates from version 31.4
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * ibdiags: Make escape character tack effect
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * tests: Make sure that end_poll() is always called
   * mlx5: DR, Fix error flow in rehash process
   * mlx5: DR, Fix DM allocation when the size is not aligned
   * tests: Fix QP extended MW bind test
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRdYcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZKQFB/9X3On2MEgdLwWAmjnm
+1tq5LL9MnTIwXh0qGxY6T+id/Zrn7+78ag8hhpiGSSFjRADJw/U217XMb11eWrH
jESBb+AJb2C8HWBRPv0ao/Prw84gMUJjnxc6/8HqKQ2K8K9tYxBZXQ7CaqHZhUwW
9QtZWazL4DAGvLJRbtkCDFH+fegeTQDg+rkfSWKz24Ab7sdGSTolTyev4dKIRoPN
OY0VTWYMaKydFjj8ZyMqqLnf8TF+YaujV765Z4rgJveUnpIT3WTm1/xD5RYUxA/v
TnLwq7ADMbnlZqEeBACKssrJX1oLYt5SVCM+0VQuKZ2aBRnb85Ld/hSd3knUdF4E
379B
=gMVS
-----END PGP SIGNATURE-----

tag v32.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:11:52 2021 +0200

rdma-core-32.3:

Updates from version 32.2
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * ibdiags: Make escape character tack effect
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * tests: Make sure that end_poll() is always called
   * mlx5: DR, Add fail on error check on decap
   * mlx5: DR, Fix error flow in rehash process
   * mlx5: DR, Fix DM allocation when the size is not aligned
   * mlx5: DR, Fix STEv1 incorrect L3 decapsulation padding
   * tests: Fix QP extended MW bind test
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRdocHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZLEvCAC3VkgMHtxXBelzN0oY
E7icGV3mNg/N7ITYtHb9W7V+Z11fX/kgdA0cC3Vv12SvZiO4V6JKjEdxS4lYyDQc
6Dq2igvvCyC0WfOy3en3hGbVI5gEQUcnOJwxf+WFoH2mjLKKhFz/PouGjqY1W+6j
4kBVeGb4/hZa+x3k7plXLDd9JT4oJuYGbheZrvz2KM/hRaO3Osyr41TdzjF/xBtj
jd0U9mwrZZujizs009PvWO7HwbIzt1gRBYlYmSCRITmE2yptE8K2OaCm4LsMMI72
jpKe8BBt4BZkfGjt4l67I9108fQ8jVQG+v6Y3b6TFIt3t6H0dnPbNl90diugiFyY
wQYb
=d5aJ
-----END PGP SIGNATURE-----

tag v33.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:11:56 2021 +0200

rdma-core-33.3:

Updates from version 33.2
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * ibdiags: Make escape character tack effect
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * tests: Make sure that end_poll() is always called
   * mlx5: DR, Add fail on error check on decap
   * mlx5: DR, Fix error flow in rehash process
   * mlx5: Fix field size for struct mlx5_ifc_qpc_ext_bits
   * mlx5: DR, Fix DM allocation when the size is not aligned
   * mlx5: DR, Fix STEv1 incorrect L3 decapsulation padding
   * tests: Fix QP extended MW bind test
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRd4cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZGfsCACBZwJ8dkYMfT+J86vv
0/HXmld7+vL0m8fUU2cgKkmPwvSjAzQVNk4eDj5SdAxQg76XtVdzbqQsuv2auU7K
y2gcBKv+0pIWQQnCnTTF19PhxKkctTachKpKdwfJA+jmN5h10JBRAnwzsId21b7b
Q3Te22D4rchTuDtFzftMjyQib0c0I8e28Wr52yuzr5skGYtpAENtjSlmYGVY/17h
byMt2x3QMMv2H7w+qGO43dJGxx47DYkmMqbF/VOJ2sfOe5l5bj0OfujDd4NtgEod
dADgV4kP0hxGLR6BPICYHmqxtL2MjYUOpGDfKebR7clUx/COaTKmaYf0D8Q8Uauq
ZuFr
=uGUb
-----END PGP SIGNATURE-----

tag v34.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:12:08 2021 +0200

rdma-core-34.2:

Updates from version 34.1
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * ibdiags: Make escape character tack effect
   * providers/rxe: Set the correct value of resid for inline data
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * tests: Make sure that end_poll() is always called
   * mlx5: DR, Add fail on error check on decap
   * mlx5: DR, Fix error flow in rehash process
   * mlx5: Fix field size for struct mlx5_ifc_qpc_ext_bits
   * mlx5: DR, Fix DM allocation when the size is not aligned
   * mlx5: DR, Fix STEv1 incorrect L3 decapsulation padding
   * tests: Fix QP extended MW bind test
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRe4cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZEb0B/9tMTiY94Bu3UielBrX
Z1LALGx8UzTcEhL6Zo3NR9/n4CFLzHwETUXl6eXq5IhABBD4fSrk2epMQsqdy9yH
LwQ0MZPaAuccMqRVs1Ds65FWPw1yJCzxUWXMRd1c0F72GkPKcDeObUAlEos4tfB4
dRUk3+3r8paAgPxiheo6D9uYWlbtDp2ACW4sPbsNIOhWn0eII9UgHKQbl0SO5V+0
42Tkl1PFKuIPsz4L3/36UDkdr1E7NmvzBB8qxFM379c02i8R5jtjv3cYMc3qj5Ju
+ThfqCqLDcoCPnnkxYI1MsT8GOVReq2wK1KDV0N/9Eumz+6z0yHTNI6rZPmT/1G6
i0JQ
=LFS+
-----END PGP SIGNATURE-----

tag v35.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:12:17 2021 +0200

rdma-core-35.1:

Updates from version 35.0
 * Backport fixes:
   * iwpmd: Zero-initialize the remote addr info
   * man: Fix typo in ibv_is_fork_initialized SYNOPSIS header
   * ibdiags: Make escape character tack effect
   * providers/rxe: Set the correct value of resid for inline data
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * tests: Make sure that end_poll() is always called
   * mlx5: DR, Add fail on error check on decap
   * mlx5: DR, Fix error flow in rehash process
   * mlx5: Fix field size for struct mlx5_ifc_qpc_ext_bits
   * mlx5: DR, Fix DM allocation when the size is not aligned
   * mlx5: DR, Fix STEv1 incorrect L3 decapsulation padding
   * tests: Fix QP extended MW bind test
   * libhns: Bugfix for calculation of extended sge
   * bnxt_re/lib: Check AH handler validity before use
   * mlx5: Fix mlx5_read_clock returned errno value
   * tests: Query NIC flow table caps before reformat
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRfMcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZEskCACEB8ff4YJdfHtWkE/L
kxpK4P4iu7CQl3hYa2uSCf4+HFvmn5e9RaqYAKPU+Txi/yNTDflCZ8uc7Tg1Uuq1
AVDK5b9g9dEJuYYimlrqZELwkZT4wGgjf9dPlO+e0MhmQulTo2HMNEg5EdrsdDO1
4yUKvUcDhNDhPA1LoiK9hM6XVzkwEgZNmcCOcvVkcqvlkRZ2zUNqbUqU4lXFOBD3
RvdoaCxC5X02Fia1286QUUOJ7IMf9AcjJgve3CddsSI9j6s39Fnv0o4oIa1gzdzv
EmSOWsqAMFzaKbCStx7wbHLXJ8KxRWJfnCZ2tXfC1mkGFRYRKfjEoJx4gsGb0Ltr
wORn
=bpoL
-----END PGP SIGNATURE-----

tag v36.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:12:22 2021 +0200

rdma-core-36.1:

Updates from version 36.0
 * Backport fixes:
   * tests: Fix tabs indentation
   * iwpmd: Zero-initialize the remote addr info
   * man: Fix typo in ibv_is_fork_initialized SYNOPSIS header
   * ibdiags: Make escape character tack effect
   * providers/rxe: Set the correct value of resid for inline data
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * verbs: Add a man page note for IBV_EVENT_WQ_FATAL
   * mlx5: Remove unused argument in raw_wqe_init
   * tests: Make sure that end_poll() is always called
   * mlx5: DR, Add fail on error check on decap
   * mlx5: DR, Use pool variable for lock instead of buddy
   * mlx5: DR, Fix error flow in rehash process
   * mlx5: Fix field size for struct mlx5_ifc_qpc_ext_bits
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRfgcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZJ/vB/95Pd5bl2UKcYpZR+nJ
w5Jia36Ei0257WZaUmfN59v66FIEF/Qmy5NMXcyXNbZanSlX3laBUy87W+pdGjPs
lxbPjSW5o7mgqeEwHzP1qJ88tXoCsVu9ZCx/pNe35xGzzaVEhb+wDiym5YIh1OXM
27jVYAO4baihj7wgCnCqbiEeHzb6J4eXetTx+l1H+VX+VnvuUbccmrEQB5S5dywe
ep/FeVYpAqpibHyYoQW5RxX9clUTSCx5lIeyErHkd7oUwr0Ya2vqwk32KhlUXlwY
+T3AeUnAJa7i57mdYMTrUesOX8/h6OnQPccu7fP2RTspwrip0JIWTaZxGjDIExUj
Jp/r
=ZlGM
-----END PGP SIGNATURE-----

tag v37.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Fri Oct 15 11:12:27 2021 +0200

rdma-core-37.1:

Updates from version 37.0
 * Backport fixes:
   * tests: Fix tabs indentation
   * iwpmd: Zero-initialize the remote addr info
   * providers/irdma: Process extended CQ entries correctly
   * man: Fix typo in ibv_is_fork_initialized SYNOPSIS header
   * ibdiags: Make escape character tack effect
   * irdma: Remove optimization algorithm for QP doorbell
   * providers/rxe: Set the correct value of resid for inline data
   * ibdiags: Don't suggest non-existing ibqueryerrors command line argument
   * ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmFpRf4cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZCcNCACFCfetc4VqWFS6nYf4
w2Pds95C27sKu+2jWdXmiw3LS9A6Nk7XEMpN2mpA5s+A+2dhZPO4qrU1ARbZESH5
RI9RZra7keS/lY12LQ9f0puME1qRz8hRwTJbk4x6kqBV6yMPqKkGfdDUbyTGunaz
zsYCoJtiCD1nvclQKxFEuE8eUtnwqIwPuCyFTk799RFqZYYe5Ke/Gik1FZwy9fjr
PNZ0l67N/9i4QjpOB98oGuytu5iC+iUGe3KSJEBHI0PKK1JQyzHl3IbhYtWfi14z
urTHvw/iATociAyv8SpYnDxJfMilUGsjTgHisBnj8nZVPqNsXJ/akdEW5/zXObM9
js2i
=7N9o
-----END PGP SIGNATURE-----

