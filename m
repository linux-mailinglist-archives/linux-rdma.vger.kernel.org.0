Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26781187907
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 06:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgCQFXc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 01:23:32 -0400
Received: from mail-dm6nam10on2109.outbound.protection.outlook.com ([40.107.93.109]:22493
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgCQFXb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 01:23:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbypH6xJYP3nCmb2s5kYkdqLE8qwLp3JnOebG/CQ5AetHpUVy5+qZRaJtLxJsQTbEOMJezP6T364FL63g+Hv2NWWmQOS+7qiaBnSD2AiR7agmLI7E49go7413fwTRfzdFY0Es8tC2If8aKw1vo3zD1wSroN/yL3MCV7liKmsZ8XEQvvEYLK6oMqIVNwCLHE+4Rg182TRe+6nkngToambWIGQF9IsRIss5IV6CYUQV1eHmLzMoVeQ7bctAfyrxnL6adJAxN5NWhQEXTzD08ATHrtrppZJ6dqswsvFw0kLYq0ZQPnrGVmkUtRLjNpTB5GRJVEWMdoGQiiTmF1TNyP6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKtQzW/TeH++D4rQBIrVzbgS2SwHp6VpdoCLylUEsAc=;
 b=JYFiAFARWiU6fNeGvCqWnKDXqirtcr2x27RqCo4fBcw3hela7mzgcji6yDy3aTduUV0KJA5w0GfqhCwlJCPWaJSWloNoiTAAEidSBNOc9ybj1PirZ5tIQ5oMvu1WCq0roBFjV/Ze9mKfyCqM3H/o1+JPXlkCtjn5q7BZ8/JnDDjuEQDCtaOm7oKQGFH+XU3jo7jXL9zZ4IgFsVRJfcQlSL7o28f3cjJDAFIneJtKIP5xK2pkRMrYEloMWjPLBomfcvHRbrkPqpxbaXkxz6Hmie06/ACZafih+fFBA2LNilcoE0700I3YDLltLAlZhdoJmDI51iMW+02sombBF9v6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKtQzW/TeH++D4rQBIrVzbgS2SwHp6VpdoCLylUEsAc=;
 b=frhwbv9AVmC1XYyB8vOMbMMcUW+rvWO3jy2ogx0uTcl/Ttznka2arR07Cs8mlpgIXdbVGqXV1oRAAbEe291UicYXZ7XEfTv2UconTFxN/Ds9YZUKg88fZ9qVzxdlLkg7PhABQX0RRcS3snMCxTUGl+XMZ6h3s39GyfVE1AQ6vGs=
Received: from BYAPR21MB1223.namprd21.prod.outlook.com (2603:10b6:a03:107::14)
 by BYAPR21MB1334.namprd21.prod.outlook.com (2603:10b6:a03:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.2; Tue, 17 Mar
 2020 05:23:28 +0000
Received: from BYAPR21MB1223.namprd21.prod.outlook.com
 ([fe80::8d1f:f622:2bc1:a518]) by BYAPR21MB1223.namprd21.prod.outlook.com
 ([fe80::8d1f:f622:2bc1:a518%8]) with mapi id 15.20.2856.001; Tue, 17 Mar 2020
 05:23:28 +0000
From:   Ju-Hyoung Lee <juhlee@microsoft.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Ju-Hyoung Lee <juhlee@microsoft.com>
Subject: Find rdma-core version
Thread-Topic: Find rdma-core version
Thread-Index: AdX8G/w1CIvOVTxSRQyfs/GZbAPOgw==
Date:   Tue, 17 Mar 2020 05:23:28 +0000
Message-ID: <BYAPR21MB1223A416AA7FE380D8DDFFC9DAF60@BYAPR21MB1223.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=juhlee@microsoft.com; 
x-originating-ip: [2601:1c2:4b00:8ff0:9b9:5798:e241:7820]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 604cc95a-8d8c-447d-a1fb-08d7ca335359
x-ms-traffictypediagnostic: BYAPR21MB1334:|BYAPR21MB1334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB1334A990E45DEC9B94A64951DAF60@BYAPR21MB1334.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(55016002)(186003)(7696005)(8676002)(71200400001)(5660300002)(558084003)(8990500004)(316002)(10290500003)(478600001)(81156014)(2906002)(8936002)(52536014)(86362001)(4326008)(81166006)(3480700007)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(33656002)(6506007)(6916009)(9686003)(107886003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1334;H:BYAPR21MB1223.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTcw3JkYsd1O+Kb7dJjAatyVvFMiSDKi5J7gws3cpDHZ1wfspUroNNhXeyy96QbK0xIt0j+MYpziQV9mAkXdXBdm+w0kBMrGFMx6yBYBe4HCFBhKP2UA/ro/xT3+8AWmnJD03E2WRQ0uTled9T4eeYJFVlp2MtKK7mrWQRKyP/BHreqSdZoLZ9+evrLNJfywFqg62DmxpCEVQsToNl0jJx8KnikXgZFl+d2eKi/YKAVQ86lct5fnDVZTpCfWFRGTYarmtsNkYwFhJV09BzTWbydbb1+wDgqlO57dOLvaPnBrLCyR87o7vUCaysN6KQ8vvy3S5E+G/Y7alKfuVOTlFYKYXT39bllALTYEdHsrqjT5NO8RS91G6AEEsOgBmWAPqBxwqDKyrqlnKSAP4+WOQ8OyOB0xY4g2nkc8GwSd3q5D4eqJeTHV3yV8sq30gL1I
x-ms-exchange-antispam-messagedata: RiijZIfVaApoLgjVzoDxqb70dlpnMc5HKqPrVcXi2xaoHwXUapjvrIwqoQusRzPPkP6dqJe7wuFByeSIR3clRT6b4TRtHNfXWUSSQHjlOAyw4X6/xosrJjBcrnXYFLtaGd1quPEkZlh3QSlzrqN41IHeZTKIVWFP+bEUnX3jTSUXyOmYeFcT/Y/b+P8oW4QHWvR/KkLVILca9xQoVXMXDw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604cc95a-8d8c-447d-a1fb-08d7ca335359
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 05:23:28.5591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9kaWgsSGT9p/J1horPTRi077wBfK0MSpOejO9Vlh0gNbR8pM3WyYiz5sEbkvtOzP0CQ9R/P5Bf7WMk2ik+EXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1334
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

Can anyone help me find what rdma-core version I installed in the system? I=
t's a set of lib and utilities, but there might be a way I can verify the v=
ersion after the official release installation.
Any help?

Thanks

Ju
