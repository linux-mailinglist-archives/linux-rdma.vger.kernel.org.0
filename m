Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302D27BF207
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Oct 2023 06:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjJJEzN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Oct 2023 00:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjJJEzJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Oct 2023 00:55:09 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 21:55:06 PDT
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F9A3;
        Mon,  9 Oct 2023 21:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1696913706; x=1728449706;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iIo/yNTLNp99CUR98k+GKJYJNiGPACWPPIpPbFXSyxU=;
  b=K58rEdBSMo370EXgZY04qcZnMMvLlzUKY9AhnVKrabihwdsvxT5y0aeS
   WsQvwtAaaGtMaPg6ms+MvfySXQDIB40G7ho2gmew2VBaN4+A7L+TlCud+
   6iabRh5wlo5ze5kZjXbwc9GsVkv7Yad5VnU36etj55iEstYGtEoQ+Exvo
   HXtMGFr982EjWCujYQQLJyyQ9tGa8wolmDdultNpHZkDCz4mgSVaBHbrc
   tVyi5bvMJcOdef0W/+HAJVPl41f67+bCLEF85Dm92317BdFvm3t5vU1ux
   LTfWFRUSuGl09UEcMp4z1XnZ2choC36F896gQRuWugUwGWfJH0Rij8rV9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="98799530"
X-IronPort-AV: E=Sophos;i="6.03,211,1694703600"; 
   d="scan'208";a="98799530"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 13:53:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kS+0D8yinWJanbresgTjADdUKfWmJcf4+lzNhxB1ErdeEp0hiKqENe4ZI6ObAnSeXxbnb1eRIaynkt07iH3MSFsWuTp0LuXg3wKI0sD+w6obcFGaPsovmjd/kpHZmtG7wi5al21NXj1DuckGcr5YsDbrIn75OeoDM1KMY9aCDzRl/9ExFOjaGKOrdyJW4I5TXtlYeBYtUkQR1Je0G52wZDq3Od5NarTkBKkc4ixN2NAvI8UHJvSv1a5NWmgnQiq36BS3IZS9WrVRXqp1EY04Z7T06wuiQong3ABFrS7u8wSI0hoWFBhUhiTFw7Cbf87rNWs3xKnRXDjydGWRPVGvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUM9TZ2MGR54qWZVPdpHu/Oy7IV/I41r1y/VaT4SmYs=;
 b=DhiMpdCK0Z0KKK7eN6p6/na9HAuy1tUqfbmr4D/UkJUp93Iw511HwkV4P/oJq3DTf5cHUdFVR/434M6i6mYcZ+1A19zm00IitGsGpBWd/9A5h9Lq4yF522ugSDCDYpuv0agv2gaMqy3VQTJfXHOiY7cLoanlh9YryiBJGOjifpYZA5bfG1sCDjwh1f8tw9PQc5Y0vk6LP6fGMtA5Q5n3UIfw4TgQwLYYGz+7eHf2rZWY6sVYBgo2FwF5fbEPvtC0n3qrPMsdgONXZJYya+SQqzSDnRDHikoaD0qthDyO3yzM+h+koCgAKlkZemP317ulqw6jJQnx7NYgPHapTgP5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OS3PR01MB5671.jpnprd01.prod.outlook.com (2603:1096:604:c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 04:53:55 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::6ade:12b9:4e6:eb2a]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::6ade:12b9:4e6:eb2a%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 04:53:55 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Zhu Yanjun' <yanjun.zhu@linux.dev>,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
Subject: RE: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Thread-Topic: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Thread-Index: AQHZ7XJmnT5Q4k7SiE+q92h7ng8TwrAs4QuAgABJegCAADH3AIAAGKoAgAAe9oCAC3pqgIAA6xwAgAAPYgCAAPfagIAAUsoAgAAIAgCABMrggIACLuVw
Date:   Tue, 10 Oct 2023 04:53:55 +0000
Message-ID: <OS3PR01MB9865F9BEB1A90DDCAEEBFC8BE5CDA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal>
 <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com>
 <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
 <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
In-Reply-To: <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?iso-2022-jp?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZl?=
 =?iso-2022-jp?B?Y2UwNTBfQWN0aW9uSWQ9YzcwODAzZmQtYTllMy00NDMyLThiYWUtNWQ4?=
 =?iso-2022-jp?B?OWM0MmYwMGJiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFi?=
 =?iso-2022-jp?B?NGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9h?=
 =?iso-2022-jp?B?NzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxl?=
 =?iso-2022-jp?B?ZD10cnVlO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQt?=
 =?iso-2022-jp?B?M2IwZjRmZWNlMDUwX01ldGhvZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9OYW1lPUZV?=
 =?iso-2022-jp?B?SklUU1UtUkVTVFJJQ1RFRBskQiJMJT8lUhsoQjtNU0lQX0xhYmVsX2E3?=
 =?iso-2022-jp?B?Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRl?=
 =?iso-2022-jp?B?PTIwMjMtMTAtMTBUMDE6MjE6NThaO01TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?iso-2022-jp?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?iso-2022-jp?B?ZC04MWUxLTQ4NTgtYTlkOC03MzZlMjY3ZmQ0Yzc7?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OS3PR01MB5671:EE_
x-ms-office365-filtering-correlation-id: b7436c97-ab03-4e6c-350a-08dbc94ce835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXYAAJBipzVUvLNB3rUgnxKvaS30apEA6DKHZaLva8gl7F0o2FwSaTYnbFwuwrJePSuxhQEvVPFP8arW0aTNuYRWrcUEst7KeDXSrPlYAh5vEbQvNfqT+yx8yzFSrcift50gQ0PrmCdp1gEQVK9TuCymtqKZiL9v/WXfiD8kQ0SLrJg3dSAj+h3rHWEtFtKjVghSNg8a7BCHEQlJtfxEIicS6VQOPCDyaM8kH/fGXzvdKMBADgUn/ByaSS2Qisk+gl2ZODkF4NzmLdIgnDHo2jR0pqhq0IayOj2S4F9ooY/gje9T44P83hGrWslj+c7vAEDAnwYwB8qBllCQze3tHSQaotrONUSzc9e5LpkqtXH8JzTemw4LrJIt8GOKD4vZFEIH/RfQfVJ7kqQONywkj39lkW8DrbQZubgCwbZJv9X/1n2R4XidOSVJZ3Cj4DbZruMIuHVHmj5OWmHEKcZxgR+uvk345oQ9hHCylyjn4sAU3Lm8+pz0HokIwMKwevJemg0FV7mdbsMICJoWjlUuei7Eq5+/Rquj19DORw+V8rCrzTKN/x+mDcBQ+7tJpc7oU5Ha2AlgkpMyz4xfIyaXt5+GV3BG96Qy1L1Kad64jz4MAJnJt/VIxJH1+ZCYM/ANqjVMwkRBbejACrLZb3Mm7QxcA/n3yUC+Pqj6mFAAw1U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(1590799021)(186009)(451199024)(1800799009)(76116006)(110136005)(8936002)(5660300002)(4326008)(966005)(66946007)(66476007)(66556008)(8676002)(64756008)(316002)(54906003)(66446008)(52536014)(7416002)(38070700005)(1580799018)(41300700001)(2906002)(122000001)(83380400001)(82960400001)(55016003)(26005)(86362001)(53546011)(33656002)(38100700002)(9686003)(7696005)(478600001)(85182001)(71200400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?cG05U0RsekIydHB4ZUNYY3NSRjVlWGZacmNxeGVTUUl1czltUlJicTBH?=
 =?iso-2022-jp?B?RXMwSHpUOWh2V2V1bWt2L3BlTnRpOUxBZVNDNmJEdEJpb0VqNmY0ZjJD?=
 =?iso-2022-jp?B?djl6aGJBVWl3YWN5aXFxR1dyVVo0eWk2T1NaVjByMTJVdGpCZ0k2VjJh?=
 =?iso-2022-jp?B?VUh2UWkybmVkL2RKa05jaUpDTjdYZlF2QzlEaSs2Mkx1Y3hkV0ZnUmN2?=
 =?iso-2022-jp?B?S1BadDBCQzE3bkwzbXF2dnNNU2xQRitkQ1NDVmNjeVVMVnZKUWJoYm1J?=
 =?iso-2022-jp?B?TkplU2hSVjUya2hHenppdGpla2NvcXBFbW42TUpiVUxJQzYrZ3FIcCs5?=
 =?iso-2022-jp?B?YUVIbEI5WTJ0YmNWNXlMcm53UzdnUHEwOHFsK3BDS1NxdE9SWkZTVFRK?=
 =?iso-2022-jp?B?MDlCN3BmMVQvc251RXVna2xRdnJWZjFQNTg0WEhhOGpsUXQySFlKWGZN?=
 =?iso-2022-jp?B?Skc2dGVKRGxKK3NKZlBORzRVR3ZuSWU0N2NRaFNQUEI1a2pOME5sNVR2?=
 =?iso-2022-jp?B?SWg0Q2dlbHowUGlMSkdGZlVkeVg5c0t4RTcrOVJVZ01Vd1dnMWlXQWJu?=
 =?iso-2022-jp?B?RzRZTDYzQ1dLbzByTVJQU1pDWTZVV2ErWUtzeFNGQ0J4eWxnVTdWRXZE?=
 =?iso-2022-jp?B?UlE0bFFNTXUrZUlYZTFCVlJHZk82V1hsKy9SZ0ozRE1sUmNOZXc3L2dl?=
 =?iso-2022-jp?B?b0NrMnVjS1gzcWZjT2Y4V05RSEs0cU43aEJKaHhYN2VhSE84c25WR0RF?=
 =?iso-2022-jp?B?OWIxcWg4bGY0NUJuYUlyWmFXbHJNYUgxT29PN1VDMmZLWGZnS01HbFlE?=
 =?iso-2022-jp?B?NWdnUUN3NWdwWHZsYU9KV09GZUU3eHMxUmgvR2pFbzEzclJObGFISGJa?=
 =?iso-2022-jp?B?WTQraEpOZkhYeWdnZDcvVUJ3d2U0dDZaTkpXVXYwc0pOdjJIcm5FTVZ6?=
 =?iso-2022-jp?B?ZEtpVWJFTlVFcVoyNWNQOGI0MGd0eDhrS283b2ZxY015aFJseGl3YTgv?=
 =?iso-2022-jp?B?bGxTejlwdjdMMnBRNnpkOUQ3SStCbkdtU081L2NuSjFNU25RdStQSjhG?=
 =?iso-2022-jp?B?OFUyRFJWZ2hwQ3pTUlRIbENjVFBhdXpKZUxYZGZlaGY3cXozQkFlME1M?=
 =?iso-2022-jp?B?cFp5ODRPR2o1bWMwTndNMENIU1ExN0RxWkNlMTJhdjNyb21NSytRT3l6?=
 =?iso-2022-jp?B?R3prdW5kRU1qK3ZpR21GUTUxa1RWVFZ2R2taRHpvUGdvN005amNROHVj?=
 =?iso-2022-jp?B?SGl0aVFuQ29Oc2RLQmN5Rkh2QkVyaC9WY3RXaGcvRFh3QzZFTmJJaTZr?=
 =?iso-2022-jp?B?ZWdEaFpVa29vMkdPTmZUNWhyaVVtV2JxbXptZjdCSXNkUHBwTEkrOElN?=
 =?iso-2022-jp?B?Z0sxaTFrT3ZpZ2NxWm90OHJwQndEdlUrZm9qYmFHVzBXdlozZlFVYlVX?=
 =?iso-2022-jp?B?UGpzL091YkJ6WEIyellJZ1JRZUhaZ2tJSFhabERzSW4xdVlMSXlFTitC?=
 =?iso-2022-jp?B?UVdOcVEwN2p2ZTI0TU5TTGdTVEFvNXhXRGYxSVQvYWtMalV5RjBXL09D?=
 =?iso-2022-jp?B?cUtHL1JOR0FmYUFHa3J6V2RUcHZBcSt5bDVjNXpGdTYzSnNjMTdoU1Ux?=
 =?iso-2022-jp?B?SlBnQWd1K1NYOXlKQnhTMUg5dDhrMmp1VUZNZjhJVmJHTDY1bHBtQ2VG?=
 =?iso-2022-jp?B?M2hsak9uVmhmMXhZTUlueEdtdi84QVZyWGJ5MmxuaU0rUzFlUlF2cGEz?=
 =?iso-2022-jp?B?N3lxS0dzQXFCTFBmYXBLdldTMlpvZmVHSm5VMGtGcHlyM3kwTUZ5azU2?=
 =?iso-2022-jp?B?Q2xnYmcwckFFRnpWVm1kdmZQMUxkemRqcnNFL0pZbk9UbU1GeXRvbmVs?=
 =?iso-2022-jp?B?UVVhMDNEMHJlNUs0Sk8rdVVRd2NIZDJYVDhFVFFxQUtDQzVKUmdNRVNG?=
 =?iso-2022-jp?B?SVloaTRsekpwMVR2THN6Nnh0TUpjUDNlUHlYM09oclIvelMyVERjdmpP?=
 =?iso-2022-jp?B?c0sxS3o0Y0RoR3BuUVdTWUxvNzg5bUpGR29YM0g4aFRZTGdnL2JKdW8r?=
 =?iso-2022-jp?B?Z3c5eEhVWnY5NVZHYWhrVnlCOWFMdE00YmYzQmFnS2Mvc3FYL3hZcjZ5?=
 =?iso-2022-jp?B?NlFKTFV1QzFJZ090Vkd5S1JGVnIyYTRhVndZa0p4Z2phdThaNnZyOUFO?=
 =?iso-2022-jp?B?QnN2RnFLd0FHZW5McWRKOFJhcVVpVXFLa3pVdmRwTS9BVU1nTWhheXRq?=
 =?iso-2022-jp?B?Z29hNEo5TVNiaUtpdm52cVdiUTliQjhRc0R6d2hISnBSY2RaZi9rUmRv?=
 =?iso-2022-jp?B?QlV4cmdVdWhwaGhQU01ZbGdCNE85aE5waEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-2022-jp?B?MEY4dGRhVlNOamRzNVBKSjFTZGZTUURnOVd2WnVxUklGUVV5N0NTWnpO?=
 =?iso-2022-jp?B?RTZyQ0lpL2R2UXJFR0xwYWZqTzRaOFBZT01DS3dlamFIdVhGdElvY09X?=
 =?iso-2022-jp?B?Y1YwVlc0NUdqUmlYMHRWNTZTUTY0bUdsNHBKbCs3ZDczNkV0Q0Y3Vzhi?=
 =?iso-2022-jp?B?VnFrdk43UkhNckxBYlhRZUxVRDZjazJHZ0NlWGorak9VQi9oRzgxcTF2?=
 =?iso-2022-jp?B?ajBMRUh6djdFbHJoS2ZHMjI4eGZaUm1HODdLd0loWXZENTNLcEZYSmhP?=
 =?iso-2022-jp?B?U2J4ME5tWjdKZ2xFOUtpYWpPc2NpU0ZtcHAydENUcjdYL2RZaitJdm5Z?=
 =?iso-2022-jp?B?dnFYRDRzZG8wclYySFhpdVU3SWsxSUFweE5iZGNBYTRtKzdoamVHYnE2?=
 =?iso-2022-jp?B?UjlvVndFcGhUWndjOUVwL3NwazhOd0ZKNDF6YTVHY1hJbE4zWk90Si8x?=
 =?iso-2022-jp?B?SVAveHRHUkFZVXBaUCtFaGw4OHdDTmtJK0YyeUQxTnYrMmNSRFpNYUt4?=
 =?iso-2022-jp?B?QnlyamJMZUVUV2huU0ZFZ3ppZ3k2NU9VVGs0dFBoM1JVY0I1MTVzSG5L?=
 =?iso-2022-jp?B?cUFRcmIxQ3pwYzduMzhUN1I4WVc0ZW94RWwzUHRXS2owMDYyVWVlZnM5?=
 =?iso-2022-jp?B?MDJQRmZxOE1QM210T2tUUGlzMTExU1lORHQva2xONms3QndWODVqODJu?=
 =?iso-2022-jp?B?cDVWdmRyZmUvRFBoVTk2WTVNS0YxRk9uQldLSEx3SkhWWENPVzgzUnQ5?=
 =?iso-2022-jp?B?L0ZwangzcXZXSyt6eVY3SlJoS002anRqZ1FQQkVVT0hyaytLbEhuVERs?=
 =?iso-2022-jp?B?QlNWL1Y0bE40TXN0R3dqUU5aZlhaQ3hhc0JVNTR1ZkNja3phWGRaZ1VH?=
 =?iso-2022-jp?B?Q0lHdVhzdE9pQkFUL0k0VDNEY3dSZEg0dGFaVVRqY1B1THRVVDVpWldR?=
 =?iso-2022-jp?B?dDdkT1dnK29VMEhRZCtFV21za2N0eHRuQjNCVi9sR09mOEdYVW5TT0pH?=
 =?iso-2022-jp?B?b05UUTZwdlE0RWFkTFRobWNzUG0yLzVVMHRTcTA2KytDaXlZZldPckFp?=
 =?iso-2022-jp?B?STMxT2hpakw0RHBwMS9FS1pMa0dKZXlLSGFWUEJYUUtXTXNqNUlXQWhi?=
 =?iso-2022-jp?B?dXVMYm1nQWxZNEVQa1NhRTRkdEdoRGNCd2d6d3kvT2ZKOW83Sm5tZ1RF?=
 =?iso-2022-jp?B?QnNQZkdOMS9Nb3hzSlBjc2lxNThwZTFPK090Yms4OEwwdlYreU5DSlZr?=
 =?iso-2022-jp?B?aWNNQnFzUHZ2Rjh6UGczSCtPWmkzZWpXOWl3aXl1YlZPcHNMNVhpazVF?=
 =?iso-2022-jp?B?ekJHV1d6a29LVmVnc0FncFM1MnRIYmFqTVJQTkpoeGlwZU1LSWtjM2Rz?=
 =?iso-2022-jp?B?MU1FUlpvNnMyUjZLL3M4dz09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7436c97-ab03-4e6c-350a-08dbc94ce835
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 04:53:55.3180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVSScNb724JoxhjUIrQ93dK35hQFLNR0qjZFPa8LOjKcAZ9op/YyjITxQ5tSaLzkoftZWfJcqTC5baGXoMJfmjDs37K+Cq7XCt95qQ+TQgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5671
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 9, 2023 1:02 AM Zhu Yanjun wrote:
> =1B$B:_=1B(B 2023/10/5 22:50, Bart Van Assche =1B$B<LF;=1B(B:
> > On 10/5/23 07:21, Jason Gunthorpe wrote:
> >> Which is why it shows there are locking problems in this code.
> >
> > Hi Jason,
> >
> > Since the locking problems have not yet been root-caused, do you
> > agree that it is safer to revert patch "RDMA/rxe: Add workqueue
> > support for rxe tasks" rather than trying to fix it?
>=20
> Hi, Jason && Leon
>=20
> I spent a lot of time on this problem. It seems that it is a very
> difficult problem.
>=20
> So I agree with Bart. Can we revert patch "RDMA/rxe: Add workqueue
> support for rxe tasks" rather than trying to fix it? Then Bob can apply
> his new patch to a stable RXE?

Cf. https://lore.kernel.org/lkml/f15b06b934aa0ace8b28dc046022e5507458eb99.1=
694153251.git.matsuda-daisuke@fujitsu.com/
I have ODP patches that is fully dependent on "RDMA/rxe: Add workqueue
support for rxe tasks". So I personally prefer preserving workqueue to reve=
rting
the workqueue patch.

Each developer here has different motive and interest. I think the rxe driv=
er should
take in new specs and new features actively so that it can be used by devel=
opers
without access to HCAs. I believe workqueue is better suited for this purpo=
se.
Additionally, the disadvantages of tasklet are documented as follows:
https://lwn.net/Articles/830964/
However, stability is very important, so I will not insist on my opinion.

I agree it is very difficult to find the root cause of the locking problem.=
 It cannot
be helped that we will somehow hide the issue for now so that it will not b=
other
actual users of the driver. Perhaps, there are three choices to do this.

Solution 1: Reverting "RDMA/rxe: Add workqueue support for rxe tasks"
I see this is supported by Zhu, Bart and approved by Leon.

Solution 2: Serializing execution of work items
> -       rxe_wq =3D alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> +       rxe_wq =3D alloc_workqueue("rxe_wq", WQ_HIGHPRI | WQ_UNBOUND, 1);

Solution 3: Merging requester and completer (not yet submitted/tested)
https://lore.kernel.org/all/93c8ad67-f008-4352-8887-099723c2f4ec@gmail.com/
Not clear to me if we should call this a new feature or a fix.
If it can eliminate the hang issue, it could be an ultimate solution.

It is understandable some people do not want to wait for solution 3 to be s=
ubmitted and verified.
Is there any problem if we adopt solution 2?
If so, then I agree to going with solution 1.
If not, solution 2 is better to me.

Thanks,
Daisuke Matsuda

