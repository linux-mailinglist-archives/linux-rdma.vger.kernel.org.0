Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0221A319331
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 20:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhBKTgc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 14:36:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37332 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhBKTga (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 14:36:30 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BJK2db027022;
        Thu, 11 Feb 2021 19:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=N1Rj3P4Bu1ub8yW2DH4xRiAc2J/mELvnvVOm2x8g4mc=;
 b=PkiOGWTf87XDrrTsJ5+e00fEScrhSY7SHNUUOO/Ff0MRzcDHcQmO8t9Hoxylif88W7E7
 OJ3yJmqaM/vrVhi/auMxQWNYg+PQT1pJTDVprBeqdmc9uZpipxmcpJBUeXXjk5VPQeCP
 +WXrlKfAn31wW7x30LD/yLUN1JSqIi6TNbgiA3jQERI+UElD+zt+2gHxGv3nw0jI4P+K
 wGi+y6ZFnH7qDm90WAGMI1yQnjFQ1FJWldfKhMTuQAJpyPYktCILxW06ozdnJNS6cULx
 AOQmEI/tznIH6y0lmdjun3EHGtUOPbpdto3S7m/HH8QbDcHNHplrSrPHczP2qW+sXds0 Fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmas02d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 19:35:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BJK4V0056179;
        Thu, 11 Feb 2021 19:35:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3030.oracle.com with ESMTP id 36j4ps0a1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 19:35:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc0Htquh4Leus52R1dX892C8w/FGKaSKyMu9O0P0RhWqp0WVPBSAuwvAZCS0mIiAd6PqB7GXV/HbHrkm4J9Gt3FG5OWiZPg4/9Gf+Si84OdHhBZUiYgkxBgap1b4KYJ5Dgkkf8bJ7xxS3vEYjIyCWZpC/7iRCpkXfoyU4WimVGgX7Y5eevDWkqugSGPRaBEYMzRMxKLqBVGGzYs4sfknuZpI1ZKwfVKRSrE9oYpfty1TypSVtd2NZYLQSHsPYKRVZJsJ+s7CLR0aLObcB6SRTmnGAdXwb2a8dk+l5XTKOEKZdy/Pf7up6Q6syJn4sQZe9Z9ho1Spdv4AxSEcyjRTnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1Rj3P4Bu1ub8yW2DH4xRiAc2J/mELvnvVOm2x8g4mc=;
 b=BpjYeInQg7fqDAYKAjLebRXih2Hn8Yg9BCucerlvOwQFdgp0dt83Y9jcOej1zLYGiS5LTZfY33KoOhpQ2GXEOe69fual410inaZEprfr3ldgKrRhyuM+06fsJ90SB2tnOh7+AivEWorkmqVVlkLUduD7M12oBh/4Nun9X1EODipiIEJoqja9BOHxUHLsBNxBLk5DgAweh73EOP0pUQJa/UvhLjFI+Lkm5eIYZGIhUkkA4dG5iydLgc4GJqHEW45xT/tDqL4mEWd/njidFBR7K8AYgYltZID/pFag2lPBaDxhP4wMXQe0ASY2sBdphyoqDiLAhGU4HqAaATGhmxHxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1Rj3P4Bu1ub8yW2DH4xRiAc2J/mELvnvVOm2x8g4mc=;
 b=jfl/ww1muKysakYY+0kT/c+DTHrLlHQqRL9fCF4fmlexInae1Q0e4sqC/HVNBRBQ5kuAc7JUSqg0tAvfCiBPQZqz403g56WAgXmxmrMz3qDgStflWhl7xxwnZPY0UJUKkiyih4WDFi9B0QPxDXg3HNVaRgBQo66E9vJAwEEdXJ0=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 11 Feb
 2021 19:35:42 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.026; Thu, 11 Feb 2021
 19:35:42 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma <linux-rdma@vger.kernel.org>
CC:     Benjamin Coddington <bcodding@redhat.com>
Subject: directing soft iWARP traffic through a secure tunnel
Thread-Topic: directing soft iWARP traffic through a secure tunnel
Thread-Index: AQHXAK0VkdC55BgtrEiwgC8y76HqrQ==
Date:   Thu, 11 Feb 2021 19:35:42 +0000
Message-ID: <61EFD7EA-FA16-4AA1-B92F-0B0D4CC697AB@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22cdff3a-ac0b-4e77-c63e-08d8cec43833
x-ms-traffictypediagnostic: BY5PR10MB4257:
x-microsoft-antispam-prvs: <BY5PR10MB4257491A1B65D63F080BA49A938C9@BY5PR10MB4257.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTxxeJhQaon1LeOc9XaBEzptC+oVWJHaEc9y3tYTzaBZcbA60ar5hQ+TcW9N+jTWWSec8k0U59BFZQ68czZZbQ3XWea9NkWMDGTTid5FXbRQpYXANak6AEQh3m28yVjXQJYhAZJj2w2kufnaJYblIHM2NyCO9XG27cdeFhKpZoc9sMjXvk07Tps1GMzS1V7RruGBz+SXdcdBjdTiHumMzHkRNYN3CAVfeYKp2cbUbvSkbI/ayazDGZIE1RnqLyFkv2FHIhxUetK0xXyWriNFqQwPGiLtONAKx0VOYyO/SGz65EM6wxGDDvuRaZZNwKxMNbU3evDFtSzZnwczJ/iXRfBvP5UBcCLp2S4bYqOhKewx0Yu8r7iT0jQpmIwrn8CTOKJXKK7j2ak5Ce+HzY1vpQrls6YiGo134sEW4GecoTGGjXtRhmFYXxPyvGVWRI2Qincj0War36HIzwYmfY/Kcp16ILZODreSfNHFIJ1I6YllKc3MizD/w9jxqtV7bQDbvIin1jSKM5RluM5aHJLF1DxA1teu1PPg4mTXvbNXvYfOsI8+QWRtrxSrKVxBtbJ9qdqEcd5WFfpAiGSvY3PeGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(376002)(136003)(6916009)(66476007)(44832011)(2906002)(33656002)(66946007)(66556008)(8936002)(64756008)(91956017)(71200400001)(83380400001)(26005)(2616005)(6506007)(66446008)(4326008)(316002)(86362001)(8676002)(186003)(36756003)(76116006)(478600001)(6486002)(5660300002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MxJrfxekrCvrqI5qBpeEXi6t4qfwiPDmF1QvFo42CL4Z/z4E54tzMGksYsiT?=
 =?us-ascii?Q?JNmcHjLi157ympOtyNBqIa8opqbZV1YzDWldljvvqnURDavJZ7ZeWH+irZBc?=
 =?us-ascii?Q?N2vgUEsBXuEdYJd+jWcXj5BmAmj4dZ3SgkFcOy096Wt6HBssIYvjAB4XpqtU?=
 =?us-ascii?Q?h2XsGke1wqrGWIDbJpUqfRDSZn9PA5aPL65cEqyI+YZ6m8WcBIeAy6F8vpcx?=
 =?us-ascii?Q?P/LHpl36lzGP0Sl8JI2WsRKl3J4Fn1YXcFyv29mtXfAp5QpTO0mlVOmgevHP?=
 =?us-ascii?Q?NjICtPcRV5kaPeIv2u1AvdGGnR7rAHAjDA2pq8NIyNHEjrUyWQoCNy97kpIF?=
 =?us-ascii?Q?Apo4+RuawaHt2Dc3kDiSyfCFnCdhdz71BgeL7OruRbupd3NUaKRAchNWGELW?=
 =?us-ascii?Q?Vzg10DZ1Fp/67PV/3BGxXx6L2yrV/bzRABU5iAU5POLNn4Ugf+5vmMYG5/iN?=
 =?us-ascii?Q?mormONscaOP4aH30HNqTIW0qIxeVkyVbUFxkFSf8w+ZyqI5vTx/Omzcp6SiV?=
 =?us-ascii?Q?dO9ETw1Mf60WGr7jLbuSLIDDgXg9uFPGai8UxED3OkymY+MQvQ9n9nlSz0pZ?=
 =?us-ascii?Q?1ZIX5efWtUeJW7eFL8D3TV7ztMV93cC+Bwlv5Zz3wuUzK/Vi/o0NawwocQfK?=
 =?us-ascii?Q?HvE4nd8jKiKthL0xdYzNHSOMCEHcjt2KwJiQeM/RXsc+AKSBVIc0YW6tVL5z?=
 =?us-ascii?Q?DJxeUEG5RXA03HEETB00EveI1wVepsoZH6p1ZKwnkza2gERCETpc8xSJljmg?=
 =?us-ascii?Q?+epk7vWr8axECaGBW6ooEF2RyU6poYW7ShDxLt7UZ8IL4Hqjb7UGSzBbc2rs?=
 =?us-ascii?Q?sjdfft/BO0DwKoUT4K2G7A7zFaf3lw4rOMRkTBFPHIsCP1/8ILbVEh1XjR6o?=
 =?us-ascii?Q?ZfXMNj+s5BclZlfSCXs8F8nx3kmwOP21PPqW5jno88go2Nc99GHmCB8ALYTs?=
 =?us-ascii?Q?dZDGBXDlEMK8Nc5X7rGg4nb0ri0S0+kUtp9iUvUBUvspYb5nvvJJdOlDKBcK?=
 =?us-ascii?Q?hVOzjVnE1MqAj9zSp+C9uuc0HSJtUvrTc58iaPdUsykLrtJrNZ4PfAT11YCG?=
 =?us-ascii?Q?hI+JTSECoz0BJHB4n4r26Zh7PbeAwDgHFKqL3r6s+oeXirTDljbkD3dIc1QL?=
 =?us-ascii?Q?LSo1PBSF2krUSfpE++dC593o48/NBnGLmdMOXLdtPIVnJcXXnE+uamF2b5jh?=
 =?us-ascii?Q?pH/abCUEP60uD2Y86E6SbGmLdktQNq558CMY4Wcc+8LThyZYymFbnyR+UKZR?=
 =?us-ascii?Q?jm6ynn9YQryJ+Wf/UfCKvfzzYPVq53fzP6btLcqWYDVpSmJSYfR+dhNgRx7b?=
 =?us-ascii?Q?VOv15EUQPFDAA1sOFoRwwcRE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1048774D8589724DB7E7A97B1FAA29D3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cdff3a-ac0b-4e77-c63e-08d8cec43833
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 19:35:42.3977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJXIE/iMHilgi4INYuXQlWAHoZT4SpHZ8ee80yAke/cgEz9U42LwAJ8GmnYHRi18XCOm1HUMHMZSvOeH/WrSVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4257
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110153
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110153
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi-

This might sound crazy, but bear with me.

The NFS community is starting to hold virtual interoperability testing
events to replace our in-person events that are not feasible due to
pandemic-related travel restrictions. I'm told other communities have
started doing the same.

The virtual event is being held on a private network that is set up
using OpenVPN across a large geographical area. I attach my test
systems to the VPN to access test systems run by others at other
companies.

We'd like to continue to include NFS/RDMA testing at these events.
This means either RoCEv2 or iWARP, since obviously we can't create
an ad hoc wide-area InfiniBand infrastructure.

Because the VPN is operating over long distances, we've decided to
start with iWARP. However, we are stumbling when it comes to directing
the siw driver's traffic onto the tun0 device:

[root@oracle-100 ~]# rdma link add siw0 type siw netdev tun0
error: Invalid argument
[root@oracle-100 ~]#

Has anyone else tried to do this, and what was the approach? Or does
siw not yet have this capability?

Thanks in advance.


--
Chuck Lever



