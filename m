Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623D83B5A3B
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jun 2021 10:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhF1IH5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 04:07:57 -0400
Received: from mail-sn1anam02on2054.outbound.protection.outlook.com ([40.107.96.54]:25759
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232312AbhF1IH4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Jun 2021 04:07:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRLQX04nKUdSuDYat7wjXoyPJ+yjhL7RGGu4gDEejUl8MtHmtO3dsl678vvofF2zytY/uoKWZq57VfEAc7hegIRGtksnhADylncX2QnvnnTQKRRPziGgFG3JWuYw+u8ihxh7a1tOx5htudJn+F0KNRiy7uUJqhwwIY8Y22Fu+XsHhbcIEcbEvR1lDqLtJdVu5lBhtS/0QW3xNZ+kDgic89hQ4vWXq9wH6EJeYR258B81pWtx0psZI2NXQeEVwgHsbBZdyZDe3c7pu/SUrSPWj5gZk4cBXPDRXgLeZkNhlIAlpBOM7n7t/VnPtCsvawLccTR6gCCMjjLDQQysVnWJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2PNfKHFwv59AxA0+LQRCmrKYN5c3Je59UUAUofN8wg=;
 b=n7r8biVOPokjvT7yqtmKVYnKzyyc1pHfTzno/vrteNb7IHi8y0/0eYqta6a8/rQval0MlgpIJImoa5uR/7jUUAZH72f8nb0esrPDzN390fza6z3FlCKh2vq1PqJ1AksrEdq9sOwnIS8hv7V9m9xMP7YcEZNA2AM0tGBFWwazVs1m115woCVraCFdJOqFwEbU+keeW1VvVfJzoYMh5uqsQcr3MOGiFIPwR48KVsCuqLpY9N8yEHKp+F6/V2bVMtBobxiL4jWFk4xggWXe2vdyvYeHmmXtAhPxfE3M55oCr92VG3kE4fe6VHjHoOt4jT7B2c7wG9uVtwNjj5ZlksD2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2PNfKHFwv59AxA0+LQRCmrKYN5c3Je59UUAUofN8wg=;
 b=ffvEC2fB3Iip/F7fOAdD25cuzJhjmGKnTv11Z/ArUL3jkZjo2sz3Vg9eiFPnY8a9ygtrjunPR0iOBF95gUjzmKujmDfL9pZUjDRlqzuYmK6bqSQpfeoGvNhLkNnj8bAd53r6fQo35wJUL/44NLEB94hKV9t7wzG3Qo3US/jAlMT2/ieVV7iwrwHhF75wT8oaj7NGT7hWIYydZ/tJYSrHEQMLIK35Fa1iAL+86MEl3M9CM7xV8sevYxwYPubNDpjpUk25pHCOLx1ZgSWUmJ0B1kP+RdGtoG4/izzUOljYJNlaefaYPLrQGBalWwckNyhr6zLciXcbDrWTwJCuA9U/rw==
Received: from PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 08:05:30 +0000
Received: from PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::69d2:50d:3dae:77d2]) by PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::69d2:50d:3dae:77d2%8]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 08:05:30 +0000
From:   Tamir Ronen <tamirr@nvidia.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Upstream IB management maintenance handover
Thread-Topic: Upstream IB management maintenance handover
Thread-Index: Addr9DEYHV2W5Gk7Tqiao+JO00ZLBw==
Date:   Mon, 28 Jun 2021 08:05:30 +0000
Message-ID: <PH0PR12MB5402DF8E4A7DA783B49917D7B9039@PH0PR12MB5402.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [2a00:a040:199:82fb:35dc:9a82:44a:3f06]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c3d8002-90f8-464a-589f-08d93a0b7f25
x-ms-traffictypediagnostic: PH0PR12MB5420:
x-microsoft-antispam-prvs: <PH0PR12MB5420524AE21B00E232341B97B9039@PH0PR12MB5420.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zWRZNZmpOzLnzC1jsPqVqIaViZn5nv5vLGu+qkQ+fsPMxc/tBkDoPSfKiC+xbFBoJFJmQ/3mzMskU018FLqBrj3DhNYShitFLmJs3Iys5nihrjh0ep2ckLu/HVC9y1eLkzzCwuFRYrOfBMu5faXH8UMcIxe/HXsTMWPZutHU8zbfrrIGYiO9pE1NUowhaQj3A19098sYmR4IKYboDgHQu8HVZKN4V+zIhD5Ywim2O2TumsbgugHHUBugjxnSnkQw9YAdpEW5CDQRpiJMjUwnlFNIWSYXY7qzG0+qg4bN9c1tMDPYVXr+C0HQyrj+Eo9mLdIljkDoHJ46B9e/TFIgtSzBFzm0fDjTS7bsRTMHv1urx8ZTpUhlfKurK4b0dGpx+5V2C8hEo57YY6lX3/LuakL2dtF13YIT7Mvvhtfy+GUeeN2+vlXCzKJHLlwRbvyQlHdx5jd/MyMHB98gsj1ojNovVlMYr6UXkQfpATCHEZ6V6hKTwKLvHDlCXzrH+FoatkaSKfq5tAyO2St2+E/HOLrBgJlht2CozDtYb32GBf+dsRUrA0godWdMCHrQIjz1T7pS1cwKmMukB7Mkc5h9BmjiX+Cinh07l9K0menE49E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5402.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(5660300002)(55016002)(9686003)(76116006)(6916009)(8676002)(8936002)(2906002)(478600001)(66946007)(66476007)(186003)(66556008)(6506007)(52536014)(7696005)(64756008)(66446008)(33656002)(38100700002)(122000001)(71200400001)(4744005)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6YoLPJ3wTzljZA952K9VPYgOViTBrjzjMBEaTFMeX8yBhxLDtOKpWqPaheXM?=
 =?us-ascii?Q?x1N4W2ZY2lEKkZDGPMmwQLCvUlTvLqF9B1JoM4TFIdcvAVqi2JMWjJZTLbW5?=
 =?us-ascii?Q?HHE8Xj4gVme7/4GNWhOZse3SgLB+zY1BgHNVUhS1rTvU6mLBZDW1oZk6KPPh?=
 =?us-ascii?Q?i1Qopwp6Rij0uPFlkjYpFHl5XDbX8rImuKdASd3cGhzdPdiS6iKQ1y5/lZ8b?=
 =?us-ascii?Q?fKveSHBeZ+c3yKpfiiM9exeMQebgVtesWJziKmmZoY4cepuojRKhLKWPcLaL?=
 =?us-ascii?Q?+RsJV9F2yT/66LVFlTGD7cdxp1oZ6HyexNHwxuYwlG8gOxAfI6JQD+U/nnX9?=
 =?us-ascii?Q?3na2IEL2DtU5r0dl583gVOO8vVQGxi46vHYyfg6nkhgQDseuQn8MZFuqaN2P?=
 =?us-ascii?Q?fXwZ2XJG8zb51fHNofKZMEg3e0q8kQoq+EwlEOcYZ6bnVu/XNDylXlz1asp5?=
 =?us-ascii?Q?R2BDJmv/ZbSMAjhGhj7aStMt7l7K9H5djD+RxEKf7XqlpfEolJ35BJm6IHgi?=
 =?us-ascii?Q?dQ5Jv6M9WBxCHuu0FU0azcr8CPa5LdKOE7e34Mj4z1izTMnCaK+7nfm2PTzT?=
 =?us-ascii?Q?LAZBItvxJDnLhRawadEfMscAEnNrgqpJIQQj+cI8hfwSpD/tCvWVGYgGyo8t?=
 =?us-ascii?Q?ogCkr/LbBDWp53PrxriFZ+q0nVvnWZi/4QGiC+ctZ7NwjO2Rq52gcKSTHxOD?=
 =?us-ascii?Q?+k5+ZmmDhj473jE4GzMNMToQhGQHB3GSdaZsa0g6WgxM7y9vJB32CjG00gKU?=
 =?us-ascii?Q?QGqhfvE/pr80jIk6sHnuiEYLsCusgtZI1Aa9XFIJaNLrxehYfvt+6qzLLxG/?=
 =?us-ascii?Q?V5jbaJep5JoWpdBeZdz6wKMz3j08aqmfVJoJGbaepHtKJSCyMkyBnWwFvsfR?=
 =?us-ascii?Q?r9EKLZbQa8a3a2KjnHO06jlU8NC+f87KABfx2WooO4XqVhKRSMRzEHobOptm?=
 =?us-ascii?Q?uPjCSvatKy+gvVC4kZH0ZLQGX8KR87CwyCg4c6yKdBiZzNPT8syAOTos8CXg?=
 =?us-ascii?Q?BOjYyRDo7XUxl93lGIjMsFlQjvZ3BYRoc+nSQBcIv146b+8p5b7qTFT6q2SF?=
 =?us-ascii?Q?bg/wPyLblTtuzWyaGdife9+9NFemS7XIdark78eByJi9vKazSXFyoJUtJgLj?=
 =?us-ascii?Q?2ZQcrwYrc+RRpgrWdeh/+kTN8Q8Nj2qr69azawzlU9Wb7BFzFuVmf/krVF5J?=
 =?us-ascii?Q?t5xMIAQM961rqzyJhl/qdc4KxwVMHOexwwaifDNJ25Pfwqgygg0e1H28fgfZ?=
 =?us-ascii?Q?cOqDj3RKxolcpljvd5+T751zlILS77eJTaxQlwy1HQyL4D7U86UdlAIxyXri?=
 =?us-ascii?Q?SYpr4KFrkIhWBBWuPtWomyuuf4MjCKCrs4o+s/hvE0ulr7dsz3dbolZKNrg2?=
 =?us-ascii?Q?TjqXLkAzAh8xQRnhjacB84CK/QZP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5402.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3d8002-90f8-464a-589f-08d93a0b7f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 08:05:30.1243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpYUIWTVnPj9HtcLgOSWvtmQmi4cRbirNP6ZWPxuDUQRhBKDjgo+zHkFVyE8+FExrRTv55LRZEu8oggWipTPog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

My two years period  as upstream IB management maintainer (for OpenSM and i=
bsim) is now coming to an end. It's been my pleasure to have worked with th=
e linux-rdma community.

Please welcome Julia Levin <juliav@nvidia.com> and Aleksandr Minchiu <alexm=
i@nvidia.com> as the new maintainers for these components. They have both b=
een involved with IB management internally at Nvidia for quite some time no=
w so they are uniquely qualified to step into the maintainership role. Juli=
a will be taking over OpenSM and Aleksandr will be taking over ibsim. Pleas=
e join me in wishing them success in their new roles.

-- Tamir.
