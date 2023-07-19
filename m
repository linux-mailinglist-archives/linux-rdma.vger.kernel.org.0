Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F9D758D5E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jul 2023 08:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjGSGCF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jul 2023 02:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGSGCD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jul 2023 02:02:03 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Jul 2023 23:02:01 PDT
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84FD1BF5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 23:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1689746522; x=1721282522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xmd5ztjzPo/pBcmC7z9ynUldbaTQDE0TVDTv6c6BSKg=;
  b=HTUMhGXELSumdeeN5qgWmkMefqSil36wxXUCMhfWDUgBPxvY33uC3mje
   6nJ1zcnoozGj8eUQ5aRwWmWvaxKtpg9Z7XdpJSGeBTfcoSsXoMN/SDE2i
   BXGFaFHxUvwt1KlVVSrTTW4B8GoVGqS4LS7F+ByrJzNgTevjZcQSf0G3e
   C6r8Q5wY4LDH8ZLyDo8R5EwPVzmeHSieSC3zr5avGU1ehgSnIJQr1upa8
   H7brRd0n/MGtfFDw6GULKSpn0G/FHNgvY1+Fc9sQAMZLmPZcXdS/qRU/I
   SVsWwwijxD9xoNorhBYitCnAI8OTIAYX9C/HBtMT0Le2hEwGgvCUTOfvE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="90059539"
X-IronPort-AV: E=Sophos;i="6.01,216,1684767600"; 
   d="scan'208";a="90059539"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 15:00:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8jRjK4quw5X6bZ/r1mRKP6wGfVemvajHsuQQ03JpuNs5H1JUpW/yl0AHcQH3XAdasnlWxWXjZ8WIcExODa9yGoApcNqqktVkfVF15e9ceHedP0hE14toUKFvqT/+gxB2DVyimg/SqlamMhfMEu1hvcPkhipW3SyMnyL+VOV7lnH3k4xRhihfV4UsQ0wYEFpSm6FmmTsCk36m0kgtTcZy2ktRCps4Q2WztJCWRhwQz3aWAGzHB8zm58SjCLz3d8AVypCdByU1k/p7sXO2HjHGC3y08aioZsIAYjU45BtsigdHHHq0k9bPwMmka5WYz5zYeXUPzWZz7MRJJR1TkX1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmd5ztjzPo/pBcmC7z9ynUldbaTQDE0TVDTv6c6BSKg=;
 b=J6oSGWHVhz+133muQzHRc4C5HY24XAfS6NDhq85Ux/6Znx6xuiMmfyMJWg+4ok+3pQlKw6x0SHVHGfQTQyIz/eOQB7pkBeiFq58G4w9f0Co7yez1YjInZ9r+LATboMKgIbNS5xJ6wZthlvAZc9V/87ZjDAQnb0hc4viynPIrULGPnQpuJOsd41X0OfTuUjDjHT8z7VX5lIlvg88uBD18LSLYq0d93JDp/E/NXNdX68VUlGF2OrkdGGjUxfSRHwPw2l+fNW49TSISsUKgkhREvdYCT4JZo+EXTzCYjiYcj4LNZ6Kts6e9Z4bBvIoHvVSgd6tjLSwv4Sh9Mv+ShdABYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com (2603:1096:604:247::5)
 by TYWPR01MB10724.jpnprd01.prod.outlook.com (2603:1096:400:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 06:00:51 +0000
Received: from OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::8ce7:52da:acd8:c28f]) by OS7PR01MB11804.jpnprd01.prod.outlook.com
 ([fe80::8ce7:52da:acd8:c28f%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 06:00:51 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Jason Gunthorpe' <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: RE: [PATCH for-next v5 5/7] RDMA/rxe: Allow registering MRs for
 On-Demand Paging
Thread-Topic: [PATCH for-next v5 5/7] RDMA/rxe: Allow registering MRs for
 On-Demand Paging
Thread-Index: AQHZiWHi2UwcKAQ2TUSskqu2LOShr6+HgFGAgDlnlcA=
Date:   Wed, 19 Jul 2023 06:00:50 +0000
Message-ID: <OS7PR01MB11804670384E92E0CAC2E5E32E539A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <7d8595c23e954e0fdc19b14e95da13ceef2adafd.1684397037.git.matsuda-daisuke@fujitsu.com>
 <ZIdFXfDu4IMKE+BQ@nvidia.com>
In-Reply-To: <ZIdFXfDu4IMKE+BQ@nvidia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDctMTlUMDY6MDA6?=
 =?utf-8?B?NDdaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1lZjExMGI0NC1iMGI0LTQxNWUt?=
 =?utf-8?B?YWZjOS0wMmQzYmVlOTU3MzE7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11804:EE_|TYWPR01MB10724:EE_
x-ms-office365-filtering-correlation-id: 9a3ba535-bb7a-4d5d-9027-08db881d816a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZrXU/EHvm/NL7bfS4q9egNJQgaQ1JxK2JHwjtigNaY65lIjf4ZJ2XcQQ/sV5Us6vww4xoDa7c0EzThT2Sv+KkTFTq/HAZpKVjHkbdxtjQiCj/S+asQMk6k17ZfuTZVGhLUWYKYJyU82NZiGiQjzjt4jVSMol/hwSZq2ktD9tPANTJ9/y2bguB0PfALIpwmLSdccid1tq1T+6JG75JNunFFiWVtyVz8vQOordYn6GOqE3QNWB++BUHZZOj/VdgHXg8HEYVvI/Zoh9e5wPBZCjcADzkcfmZtjcwHZNkwng+MnKKqL0IhDX/n0liBedsIShn6FXZzeUxD1PH519wPfGgHXhe/mr8xhvNGOhio73P6DephsoNwpHWuDRETww4iCd3nPbVOKU4TeakjofElMuS87jJ2cXGuYZ+DW50cXjMzg3jhvIxjHbMjI3QFFqTW3G9+KeLv6OArpVJub5MIkeJOBEQs2jJxp2TdjFPVNxXjoNRazeXpPLBYnDRQ+qayno3nfG/fRjydj8X5276ifcdvmMy/lFAWTP3nZFgbTyg2bwtMGCMcO0mNe2j6IUBK49Jcrbnl0Td5RhR/3DYS1MyQRnq+0npXPo1FU4QzynqKyZ2Nihr8KVS2fFtSMR+srB0ya5zFDaY51koHY3qYrN1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(1590799018)(451199021)(9686003)(55016003)(1580799015)(107886003)(53546011)(6506007)(26005)(54906003)(85182001)(38100700002)(122000001)(38070700005)(66946007)(52536014)(5660300002)(76116006)(2906002)(4326008)(316002)(64756008)(66446008)(66476007)(66556008)(6916009)(33656002)(8676002)(8936002)(41300700001)(86362001)(7696005)(71200400001)(478600001)(82960400001)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVA2ZW9TTHJGVEdibU13OVloRzNjb2RjR0YxR3RDWUVwMkIyRnBQQmZweldC?=
 =?utf-8?B?ZU1MTVJoOVFidTF2OVNCd2hCdDNpbWxXMEREZDhjYWtWZTgvVlY3NTQ3RjNI?=
 =?utf-8?B?RVdqS2lET1hoVzJJSkJzQ2x4ajNld29kK2pFMWxrMmhrNGl0UFR3aFhLV3dM?=
 =?utf-8?B?Yzkxa1hPaUFyRFpjMlV2bDBnVExQZlNUelpPT1YvZlpDeDlHQmhPaEw0bml3?=
 =?utf-8?B?YWpMbS9QVjN6NEkwTGRxalFBWi9JUnJVU0Z1ekZvSXlYQVhzSllhTEZmYzZE?=
 =?utf-8?B?UW5mSTBJdTd2SFl1VGlRK2VUZEJYQlUrdU9UMjM2cXJGeWIycEtyMXFmZUNx?=
 =?utf-8?B?aVZkWVF6ZlBlamh1Mk5jU0VuVXZYVzFnU1pud0l4VE5tOGFOY2tuRU5USkJp?=
 =?utf-8?B?SmRxVWdWTkRCM2laZGwycnhYellMbnhHeGxUVEYyRWRvNVF0VGNFUURObUJF?=
 =?utf-8?B?UlovNXNuakplUG9BdWJNbGRUR0gzbUNSZUplTlRRbU1SYklhZkhJUTVUQlhw?=
 =?utf-8?B?RDdqbFozZHVvaExGMG1CMnFaWWFkbU9zR0hvTHVaWUt2M24yUFZyQmN1SjNI?=
 =?utf-8?B?SjJNa2NpUjNmM2I5OU9nUmJ2THI3a0NoQ3A3Z2tTZmVtN3F1a0RZMjlYMVJK?=
 =?utf-8?B?LzZtZHExZHJFUk5nNE1tbG43c1FXR0U1V2krMFB4UVgvYmdKLytvSXVWYVg1?=
 =?utf-8?B?bG5zM0RoQ1lBVVc3VDhLUkhLRmhTcUlpcFZzZG5mQVRsODliTzNZZExkUiti?=
 =?utf-8?B?dFM0RGRIWTQyY3ByZkFHWktyUGo2MndoaGlWTUs3Z0xRQ294UEUyOFR3OVRM?=
 =?utf-8?B?cm9KY2cwUWUzUEJSYjRkc1c1ZWh0SU5la0lzbFVVRVlIcmpaWTNSZk0zTFk5?=
 =?utf-8?B?WVFGeGc1eG5MUXp3WWxzZzdXWE03dWdoNXB4eE53T29Qd0ViWVFDZm52TjV1?=
 =?utf-8?B?SVVXdHljWnlMRXVldjd6aDY0YjB2UER5V0lXVHBHZjFVcXkzTlppRTArS3pS?=
 =?utf-8?B?bkZoSExyTlRIVHdUenEyb0M4VFhrL2VaRGQwcTJ0Qkd4WUJjRmhsazJHMER1?=
 =?utf-8?B?alUrb0dqWW9JbzN1bStwOTR2RWkzZG0wcE1yRCtnREJQVmk5VjRUTWlPRW1Y?=
 =?utf-8?B?bDJaVFRnTWI5YWdKRzJGRGhDOHJxNnhlQlpxU0p6cTJ0Ukt4ZVN3MXhoZjhv?=
 =?utf-8?B?eDlZK3ZHaHNPdjFIa3p0TWZ4WHJjMWlDUkZ3aUY4aUo5bFBQUExXeXZtMExG?=
 =?utf-8?B?a0crQ2lkZ0xzUkM2TU05YjFVQzRkb3RPWVY3UUFWajEyREtaTU9sN0Z4UllV?=
 =?utf-8?B?NXBmWU5hUFRTcHlTbFhleHhLS0NPa2xCRHZ0OWZJU040bS9HNGErZ2hoNXNL?=
 =?utf-8?B?Nm9yZkRXSHY3a0dQekdrNXdYaUlXOW92RmZyb2d3M3BPZDBrNnB0eHo2TEFC?=
 =?utf-8?B?VWFmWGpocFNJSkZIZ3BVaFZvWWlNT1NtZ3VJenZpVzFlL3VFZVhUTGpDQ0J5?=
 =?utf-8?B?dHlST29ZNlVvU05ZelovTUFjK3ZKaWlpQjA0UG5GbjdrQnBDT0Y5amVLa21N?=
 =?utf-8?B?YWJsMWFXa0RzN2w4TGhvb1pFbENMV1RUbVVGMnVnVTVaektwcTM3Qm9oN0tD?=
 =?utf-8?B?d3dvRjBERHEzcmlBYnhDRWtiZmdyYUwwVlc0bTlkMWttYW9Oc1RQeGRqVzBG?=
 =?utf-8?B?a0tONWNBaHRveDZVSjJBUlc3T3FhWEt2MmQxQXZoRnlNK0d6TjhKVEJlODNp?=
 =?utf-8?B?Qk5wUlkxQnE5eG4vUzFVSS9aa0Z0TzB3aVdSTGo5b2t6SFp4RTVVMmdScFRZ?=
 =?utf-8?B?YjFKVy9KejZLQWdZc01vdXpqWDc1elZrekZHZFFhMGZYd1Rsdm1VdWplWmlz?=
 =?utf-8?B?OWppUmZpTTZibmpMNTkySkhwc1hiQlNKdEtBbEZBK3R6cTFRSnczUDA5aDlq?=
 =?utf-8?B?Q3dvTG9SVEdZQ08zaERxeUw2MUdJSDdCSUZZbUtrQXNnWXA3Z0M5UFJYb1VD?=
 =?utf-8?B?a1AvZFJQdndrR2JLdkdvSUplVSs0Z2VKR0FNVDZsOUswbS8xVGZzMWdmUC9E?=
 =?utf-8?B?MU4rNjJPMW85Nk1LdG5QWXh0T3E4Z3FSUzBrVUxXZjBPZ3JqQjEzT05lS1pK?=
 =?utf-8?B?ellPdmpWVWpLWUdSRHppd3dlOHNBUkp1Y2tVc2lmSWtwTHppRksrVXcvdzRQ?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wL52zv+kKJ5gtUlBqOX7VR7I7Te+UtvYyhgXLQ9NwwdO0rSgVHYv7vJpgLsIt384jSN/zYtIpYVGX2Ov23x8T3IRXRVYKW2i0lWzHC1ztqIztqkH8KLieAO12M32P1s4Se/zBzjbbmhG4CfDewYJmdgzxvjNC9vCxWCYvEZHz8TM2I/go0EzPsBWvEwuux8jqmtG/llfoUsbYe26UMJ+TCP35ZQdohbwVd5PLzVq/rjOodfoG7vGEWpS/QSUeALrw5vDrn+b/KjMg6g8y01VTnXAQpRye1bhv+SDsVIkmtcUurBjN0eI8V9MClACLtotF92koBpWJi8LOCWrkXXpS7/2X7Z+YddH46cm4nT6GZK0rXSBCinUMG8vy0DJTiNu6zJXyO3I+ZwdOoxkh39llPv5CEawb0Eqak2eRigMahQ0TUMwblRnSB8PniezJy6/MX8BAe/agpYVMBOTN7//IfbOhC4dm74IU8389wHLn+TgOhMN1X80AjZDDeA9UiiizvUvoG8DvQxEeS2TnJWxzT/lYDJ6wclt4XWGrZCh0xexIhnW7PWqu7teAmoBpTiE2mKm2aiVb5+yLRcRhU6xU9CQAU/ygAZLzWESBz3yn0izW3g8ZSX/i3qmvFf+Tv2PlB4UFXqCTEEGK88KIwdhsZgo9V7JE01BXyKj+fw9tyQbnxqd4GScIZ4bby1m3KepkwWTQDm18RclZ1IgPaBp0V5a9TBg93gb8euMEFk1iS/8xSQSFAR6PzeigCCbFrp9/qX/YFUBNNojLwXkA/jKGVFhimHdfohd0pDUIsS/95ZejLz3S8HmbRnZ7jWRe5tu8PPcYKTqnGzmrrmfO1EQ2Q==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3ba535-bb7a-4d5d-9027-08db881d816a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 06:00:50.9684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lxp0yOjRNBbEHDjrh0/ZTjEud4nIOlKYMtqWmvNWOWJ69IaWPfSHysVJuW+g+PaCzv9dFQaQMwk1dSWSKHozMAQkVsQQdfruf8stWpmF5Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10724
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVHVlLCBKdW5lIDEzLCAyMDIzIDE6MTkgQU0gSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KDQpT
b3JyeSBmb3IgbXkgbG9uZyBzaWxlbmNlLg0KSSBtdXN0IHNwZW5kIG1vc3Qgb2YgbXkgdGltZSBm
b3Igb3RoZXIgd29ya3MgdGhlc2UgZGF5cywNCmJ1dCBJIGFtIHN0aWxsIHdpbGxpbmcgdG8gY29t
cGxldGUgdGhpcyBhbmQgc3Vic2VxdWVudCB3b3Jrcy4NCg0KPiANCj4gT24gVGh1LCBNYXkgMTgs
IDIwMjMgYXQgMDU6MjE6NTBQTSArMDkwMCwgRGFpc3VrZSBNYXRzdWRhIHdyb3RlOg0KPiANCj4g
PiArc3RhdGljIHZvaWQgcnhlX21yX3NldF94YXJyYXkoc3RydWN0IHJ4ZV9tciAqbXIsIHVuc2ln
bmVkIGxvbmcgc3RhcnQsDQo+ID4gKwkJCSAgICAgIHVuc2lnbmVkIGxvbmcgZW5kLCB1bnNpZ25l
ZCBsb25nICpwZm5fbGlzdCkNCj4gPiArew0KPiA+ICsJdW5zaWduZWQgbG9uZyBsb3dlciwgdXBw
ZXIsIGlkeDsNCj4gPiArCXN0cnVjdCBwYWdlICpwYWdlOw0KPiA+ICsNCj4gPiArCWxvd2VyID0g
cnhlX21yX2lvdmFfdG9faW5kZXgobXIsIHN0YXJ0KTsNCj4gPiArCXVwcGVyID0gcnhlX21yX2lv
dmFfdG9faW5kZXgobXIsIGVuZCk7DQo+ID4gKw0KPiA+ICsJLyogbWFrZSBwYWdlcyB2aXNpYmxl
IGluIHhhcnJheS4gbm8gc2xlZXAgd2hpbGUgdGFraW5nIHRoZSBsb2NrICovDQo+ID4gKwlzcGlu
X2xvY2soJm1yLT5wYWdlX2xpc3QueGFfbG9jayk7DQo+ID4gKwlmb3IgKGlkeCA9IGxvd2VyOyBp
ZHggPD0gdXBwZXI7IGlkeCsrKSB7DQo+ID4gKwkJcGFnZSA9IGhtbV9wZm5fdG9fcGFnZShwZm5f
bGlzdFtpZHhdKTsNCj4gPiArCQlfX3hhX3N0b3JlKCZtci0+cGFnZV9saXN0LCBpZHgsIHBhZ2Us
IEdGUF9BVE9NSUMpOw0KPiANCj4gQWxsIG9mIHRoZXNlIGxvb3BzIGNhbiBiZSBwZXJmb3JtYW5j
ZSBpbXByb3ZlZCBhIGxvdCBieSB1c2luZyB4YXMNCj4gbG9vcHMNCg0KV2VsbCwgZG8geW91IG1l
YW4gSSBzaG91bGQgdXNlICd4YXNfZm9yX2VhY2goKScgaGVyZT8NClRoYXQgaXMgdGhlIHNhbWUg
J2Zvci1sb29wJyBhZnRlciBhbGwsIHNvIHBlcmZvcm1hbmNlIG1heSBub3QgYmUgaW1wcm92ZWQu
DQpBZGRpdGlvbmFsbHksIHRoZSAnaWR4JyB2YWx1ZSBhYm92ZSBtdXN0IGJlIGNvdW50ZWQgc2Vw
YXJhdGVseSBpbiB0aGF0IGNhc2UuDQoNCj4gDQo+ID4gIAkJCQkgICAgdW5zaWduZWQgbG9uZyBj
dXJfc2VxKQ0KPiA+IEBAIC01NCwzICs3MiwxMDUgQEAgc3RhdGljIGJvb2wgcnhlX2liX2ludmFs
aWRhdGVfcmFuZ2Uoc3RydWN0IG1tdV9pbnRlcnZhbF9ub3RpZmllciAqbW5pLA0KPiA+ICBjb25z
dCBzdHJ1Y3QgbW11X2ludGVydmFsX25vdGlmaWVyX29wcyByeGVfbW5fb3BzID0gew0KPiA+ICAJ
LmludmFsaWRhdGUgPSByeGVfaWJfaW52YWxpZGF0ZV9yYW5nZSwNCj4gPiAgfTsNCj4gPiArDQo+
ID4gKyNkZWZpbmUgUlhFX1BBR0VGQVVMVF9SRE9OTFkgQklUKDEpDQo+ID4gKyNkZWZpbmUgUlhF
X1BBR0VGQVVMVF9TTkFQU0hPVCBCSVQoMikNCj4gPiArc3RhdGljIGludCByeGVfb2RwX2RvX3Bh
Z2VmYXVsdChzdHJ1Y3QgcnhlX21yICptciwgdTY0IHVzZXJfdmEsIGludCBiY250LCB1MzIgZmxh
Z3MpDQo+ID4gK3sNCj4gPiArCWludCBucDsNCj4gPiArCXU2NCBhY2Nlc3NfbWFzazsNCj4gPiAr
CWJvb2wgZmF1bHQgPSAhKGZsYWdzICYgUlhFX1BBR0VGQVVMVF9TTkFQU0hPVCk7DQo+ID4gKwlz
dHJ1Y3QgaWJfdW1lbV9vZHAgKnVtZW1fb2RwID0gdG9faWJfdW1lbV9vZHAobXItPnVtZW0pOw0K
PiA+ICsNCj4gPiArCWFjY2Vzc19tYXNrID0gT0RQX1JFQURfQUxMT1dFRF9CSVQ7DQo+ID4gKwlp
ZiAodW1lbV9vZHAtPnVtZW0ud3JpdGFibGUgJiYgIShmbGFncyAmIFJYRV9QQUdFRkFVTFRfUkRP
TkxZKSkNCj4gPiArCQlhY2Nlc3NfbWFzayB8PSBPRFBfV1JJVEVfQUxMT1dFRF9CSVQ7DQo+ID4g
Kw0KPiA+ICsJLyoNCj4gPiArCSAqIGliX3VtZW1fb2RwX21hcF9kbWFfYW5kX2xvY2soKSBsb2Nr
cyB1bWVtX211dGV4IG9uIHN1Y2Nlc3MuDQo+ID4gKwkgKiBDYWxsZXJzIG11c3QgcmVsZWFzZSB0
aGUgbG9jayBsYXRlciB0byBsZXQgaW52YWxpZGF0aW9uIGhhbmRsZXINCj4gPiArCSAqIGRvIGl0
cyB3b3JrIGFnYWluLg0KPiA+ICsJICovDQo+ID4gKwlucCA9IGliX3VtZW1fb2RwX21hcF9kbWFf
YW5kX2xvY2sodW1lbV9vZHAsIHVzZXJfdmEsIGJjbnQsDQo+ID4gKwkJCQkJICBhY2Nlc3NfbWFz
aywgZmF1bHQpOw0KPiA+ICsJaWYgKG5wIDwgMCkNCj4gPiArCQlyZXR1cm4gbnA7DQo+ID4gKw0K
PiA+ICsJLyogdW1lbV9tdXRleCBpcyBzdGlsbCBsb2NrZWQgaGVyZSwgc28gd2UgY2FuIHVzZSBo
bW1fcGZuX3RvX3BhZ2UoKQ0KPiA+ICsJICogc2FmZWx5IHRvIGZldGNoIHBhZ2VzIGluIHRoZSBy
YW5nZS4NCj4gDQo+IEFsbCB0aGUgY29tbWVudHMgc2hvdWxkIGJlIGluIHRoZSBzdHlsZSBsaWtl
IHRoZSBmaXJzdCBvbmUsIG5vdCB0aGUNCj4gc2Vjb25kDQoNCkkgZ290IGl0Lg0KDQo+IA0KPiA+
ICsJICovDQo+ID4gKwlyeGVfbXJfc2V0X3hhcnJheShtciwgdXNlcl92YSwgdXNlcl92YSArIGJj
bnQsIHVtZW1fb2RwLT5wZm5fbGlzdCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIG5wOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHJ4ZV9vZHBfaW5pdF9wYWdlcyhzdHJ1Y3QgcnhlX21y
ICptcikNCj4gPiArew0KPiA+ICsJaW50IHJldDsNCj4gPiArCXN0cnVjdCBpYl91bWVtX29kcCAq
dW1lbV9vZHAgPSB0b19pYl91bWVtX29kcChtci0+dW1lbSk7DQo+ID4gKw0KPiA+ICsJcmV0ID0g
cnhlX29kcF9kb19wYWdlZmF1bHQobXIsIG1yLT51bWVtLT5hZGRyZXNzLCBtci0+dW1lbS0+bGVu
Z3RoLA0KPiA+ICsJCQkJICAgUlhFX1BBR0VGQVVMVF9TTkFQU0hPVCk7DQo+IA0KPiBQcm9iYWJs
eSBzdWZmaXggdGhpcyB3aXRoICJhbmRfbG9jayINCg0KQWdyZWVkLg0KDQo+IA0KPiA+ICsJbXIt
Pm9kcF9lbmFibGVkID0gdHJ1ZTsNCj4gPiArCW1yLT51bWVtID0gJnVtZW1fb2RwLT51bWVtOw0K
PiA+ICsJbXItPmFjY2VzcyA9IGFjY2Vzc19mbGFnczsNCj4gPiArCW1yLT5pYm1yLmxlbmd0aCA9
IGxlbmd0aDsNCj4gPiArCW1yLT5pYm1yLmlvdmEgPSBpb3ZhOw0KPiA+ICsJbXItPnBhZ2Vfb2Zm
c2V0ID0gaWJfdW1lbV9vZmZzZXQoJnVtZW1fb2RwLT51bWVtKTsNCj4gPiArDQo+ID4gKwllcnIg
PSByeGVfb2RwX2luaXRfcGFnZXMobXIpOw0KPiA+ICsJaWYgKGVycikgew0KPiA+ICsJCWliX3Vt
ZW1fb2RwX3JlbGVhc2UodW1lbV9vZHApOw0KPiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKwl9DQo+
ID4gKw0KPiA+ICsJZXJyID0gcnhlX21yX2ZpbGxfcGFnZXNfZnJvbV9zZ3QobXIsICZ1bWVtX29k
cC0+dW1lbS5zZ3RfYXBwZW5kLnNndCk7DQo+IA0KPiBVaD8gV2hhdCBpcyB0aGlzPyBUaGUgc2d0
IGlzIG5vdCB1c2VkIGluIHRoZSBPRFAgbW9kZT8NCg0KVGhpcyBmdW5jdGlvbiBmaWxscyB0aGUg
eGFycmF5IGluIHRoZSBub24tT0RQIG1vZGUuIA0KWW91IGFyZSBjb3JyZWN0IHRoZSBzZ3QgaXMg
bm90IHVzZWQgaW4gT0RQLCBidXQgdGhpcyB3b3JrcyBzb21laG93Lg0KSSB3aWxsIGZpeCB0aGlz
IHRvIGZldGNoIHBhZ2VzIGZyb20gdW1lbV9vZHAtPnBmbl9saXN0IGluc3RlYWQuDQoNCj4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3ZlcmJzLmggYi9k
cml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5oDQo+ID4gaW5kZXggYjZmYmQ5YjNk
MDg2Li5kZTVhOTgyYzdjN2UgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfdmVyYnMuaA0KPiA+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X3ZlcmJzLmgNCj4gPiBAQCAtMzMzLDYgKzMzMyw4IEBAIHN0cnVjdCByeGVfbXIgew0KPiA+ICAJ
dTMyCQkJbmJ1ZjsNCj4gPg0KPiA+ICAJc3RydWN0IHhhcnJheQkJcGFnZV9saXN0Ow0KPiA+ICsN
Cj4gPiArCWJvb2wJCQlvZHBfZW5hYmxlZDsNCj4gDQo+IFlvdSBjYW4gdGVsbCBmcm9tIHRoZSB1
bWVtLCBkb24ndCBuZWVkIGEgZmxhZw0KDQpDZXJ0YWlubHkuDQoNCkRhaXN1a2UNCg0KPiANCj4g
SmFzb24NCg==
