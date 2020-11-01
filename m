Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C832A21A6
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Nov 2020 22:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgKAVAR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Nov 2020 16:00:17 -0500
Received: from mail-eopbgr750119.outbound.protection.outlook.com ([40.107.75.119]:34563
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbgKAVAR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 1 Nov 2020 16:00:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZjG5KZSQZ3XW2FX5fdGtMc/H4+b/IaKR3tkZDqDp38qNHetrfB7EiGpjlDIj0ZPObjdmzQiU02uV5i0zw0VRnaIqNTpTPebhnM/rV4gBjimlQvPP0BhnlidP08xgZlg1ug/eexbWpx4pdGlpUH2JTVsV23zjebH2B00/yrC9tYiUaeBL3V7YJK7MM+Z29AijJjzEAN6o8mA9C//ppiF1wNTfdeeEliyiBrqxjxIoiOymQT8KyOsm5/65/FgZ9A4aVElWmzQkx53MI1Jqz4psZu9esCKD5j7+u01AA+wENC0urf72T+3Od6+w4JdejKPRLuuTJkFdOYi7q/X1GzC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2WdOABzmTEAI6XD4uaLf4tZnAioOnrK6c/3fcZKXHs=;
 b=lATicUpV+RlemBkLhgQjqjk20Ari8U0qh7aAXcXwEu3Zi6g4Unopk+jiQUoY50PFtDpJZAcXFWb6HQEzjxEXFiO64hvCaYqY2d9yYBbPk+FkYIHox3kze5yTj6giufF/2an6pSJxUaGSSa/F3xGKayyRRZrNFyO4dy+ksTs9r7doigCW+lc5w/x8Eeh8ZDArQau1eOjKQwhooSwjpiECoRukPSizXd5brLeC/TKevHRwX3LZsJ4TZJcjp7z+BwFCaEnH0RcmJdbzWgnZY1F/RDfiGqp6oFRFnpaUWaH7l4SYnNJJcfyieeNkmhMFF7r1nPVEiPQ3Wy3+4ZBzOTNcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=northeastern.edu; dmarc=pass action=none
 header.from=northeastern.edu; dkim=pass header.d=northeastern.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=northeastern.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2WdOABzmTEAI6XD4uaLf4tZnAioOnrK6c/3fcZKXHs=;
 b=UeLoiWxi/GFmOqZTWdWjiShGJAAmflMxiti2Qe3DHbd6csshGuxp7YSRpgXtwZ3g3AfqhYmnewH34uZo4PxV7Nb+F7h29Owbj4X45qmVzZDK++ShVe5NuJyOPeLntfuzTnILbeOi87n66q6GH0nV1IN5rJdp7fuD/f0LqVIpLD4=
Received: from BN6PR06MB2532.namprd06.prod.outlook.com (2603:10b6:404:2a::10)
 by BN6PR06MB3475.namprd06.prod.outlook.com (2603:10b6:404:119::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sun, 1 Nov
 2020 21:00:14 +0000
Received: from BN6PR06MB2532.namprd06.prod.outlook.com
 ([fe80::2c22:5dbb:becd:88d]) by BN6PR06MB2532.namprd06.prod.outlook.com
 ([fe80::2c22:5dbb:becd:88d%3]) with mapi id 15.20.3499.030; Sun, 1 Nov 2020
 21:00:13 +0000
From:   Changming Liu <liu.changm@northeastern.edu>
To:     "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        yaohway <yaohway@gmail.com>
Subject: How to fuzz testing infiniband/uverb driver
Thread-Topic: How to fuzz testing infiniband/uverb driver
Thread-Index: AdawkarIjS+Q8tCzT3S+sAjKAmsjCQ==
Date:   Sun, 1 Nov 2020 21:00:13 +0000
Message-ID: <BN6PR06MB2532A875B6C3AC57072570B6E5130@BN6PR06MB2532.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=northeastern.edu;
x-originating-ip: [173.48.78.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da5ec204-f56a-409b-09e1-08d87ea920be
x-ms-traffictypediagnostic: BN6PR06MB3475:
x-ld-processed: a8eec281-aaa3-4dae-ac9b-9a398b9215e7,ExtAddr
x-microsoft-antispam-prvs: <BN6PR06MB34754080971A65708B708B1AE5130@BN6PR06MB3475.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IDMikXDZYsA9AL8JJ7P1ii7uCXmzwBl4KVsY6BCBm4jOKT9bNYDrstshRMf16fj2YRAe+gXuwKTZBBTc7mjOP8h1pav/UVg30HK7a+U227BIZZKN+KBVDuSuSROCcE/nnS4NtwQ+zxE6/kjpR9TKOJPK2g6L47smOVB+G8dnYQaLBEwrnZWx/QrTfkyAxBdcxfy7C5IcaIlNUiPziJwvsUn5crsw+5Je+1t1RfqqpRvmLQX9pHd18rvqlhL9BapGA4xBG7Q1ipl42kVqs1YHfvX/Wab0A9FqoAKIvte8bOeLoNUswbH7uVftifGwfzy7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR06MB2532.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(6916009)(8676002)(2906002)(8936002)(4744005)(33656002)(478600001)(9686003)(71200400001)(66556008)(66476007)(66446008)(64756008)(55016002)(6506007)(4326008)(316002)(186003)(86362001)(5660300002)(66946007)(52536014)(76116006)(83380400001)(54906003)(786003)(7696005)(75432002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wZ/7V5+kLkmNMb93E5wCTqeABZ6eYhqindrutwZEdzSi9hB9xQoWQzUYGU5mSIhvWWeUE0JoFvZLY+wuDrlOoHqNsULAZZ9EMTB22TvxN5gcg52A6IrhubdTHdiikgVaKrrNucTmatxQxdFQZsD/I/ASESzO46qhhZR95yspd+r2fL3c4QcBe8pr8k+OIO15Ev4bOe3Hb6DlIcWcdYBGVTS8qCyA5YNlEnTMHe2QUuEQghmXZrO/AuxT1rtSeqmcPM96gjr+OyD6ZiseI9nMsEGF8LY25ZtLa1S1rOL268whylrh0vcAaAfEmVZ2kWSd5NC96BbYktBPAsNvLE5lOt5YBNlUTBzeQX7e+Ssl0bTt+sqrUUYgs60WXO9TcWOp4IcfGCdsIQmLESJ4hjK6o6EVapJcwGUXUyS4RG0hIvxHnVexX/REffovRlotahw29YoyKrYVho5Aj/kZQW38pyAGFKpmpt46KtP+s0eCYrjnuC15IH1gsrYRXrxz+Yf784SRGyGhicv/vKUcjntdFrrMHh/VdfoNExVk/Lq/ecf49UdrHKXs4HJtpfaqBXWyYY9PHeAIAYpZsWnd3FFncVJekONquFEM2owcJ7k4DWrQHx0vasSSX+vD3K7xwg5Wi/QUyyTOpjL9KRTvofIyVg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: northeastern.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR06MB2532.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5ec204-f56a-409b-09e1-08d87ea920be
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2020 21:00:13.3114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a8eec281-aaa3-4dae-ac9b-9a398b9215e7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6HiatUSyboc4O5X90NfM18jWFCUjUm4FzvOIpO9Tm76E6cMNvOsNynaYICanaVffaDCFjKFpfXj8B2L3GDZ6Uh9JTOLBV305m4KhB0SonLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3475
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,
Greetings, I'm a PhD student interested in linux, I found a bug in=20
drivers/infiniband/core/uverbs_cmd.c via static analysis.

As a follow-up, I planned to fuzz testing this driver using syzkaller
to confirm this.
However, according to the doc in Documentation/infiniband/user_verbs.rst,
(it's a bit out-dated BTW, as CONFIG_INFINIBAND_USER_VERBS is not used anym=
ore).
I built the kernel with all related options set to y, installed libibverbs-=
dev,
and added KERNEL=3D"uverbs*", NAME=3D"infiniband/%k" to my udev rule.

there is no 'uverbs0' file created under /sys/class/infiniband or=20
/dev/infiniband/. So may I ask how to properly set up my testing=20
environment so that I can fuzzi testing this driver? Is a physical
device required?

Any information is greatly appreciated.

Best,
Changming Liu
