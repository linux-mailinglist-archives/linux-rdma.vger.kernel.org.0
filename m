Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAAF28C4D8
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 00:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389703AbgJLWiy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 18:38:54 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:14486 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389220AbgJLWix (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Oct 2020 18:38:53 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CMT6d7011305
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 22:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=mCKNtCLU/3gzyExcAh1hKu0L3KGKBuuHLI6zD7lKb5g=;
 b=VXRChPK/9n7JVjHfDxKlp2CMM/ucL75pyIQxaQPozStLhV0m+ZcYzD8wD0rej2gfMwOk
 CANPg4sxvss3b7FRfk1zG9F/tsdE3V6/32UFINT4KkJRUYbXyzugFR+5oXM0+AsqFRXl
 BdZiFBv6OAf77hzpGHQY6U7ZQR653lqFZNJdiQrCr2sDW/KgIbx365EKTYzQqoPJK9ng
 lwJDubfv2pPZS/KeonStjrnZpj1pueO9Lya/3WAR6WjX8T7BICAlHKatZuYTlnKQieRC
 RmHH0uYuBvEJTevxBJMC/0wfgVhxpMY9wSocMY/gt4z5x4CB7GYV3ioCiE1+zvDA+699 3w== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 343ptxnpap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 22:38:52 +0000
Received: from G9W8455.americas.hpqcorp.net (g9w8455.houston.hp.com [16.216.161.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 1797760
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 22:38:52 +0000 (UTC)
Received: from G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) by
 G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 12 Oct 2020 22:38:51 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W8454.americas.hpqcorp.net (16.216.161.4) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 12 Oct 2020 22:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDKjuPF7zTMmk9p6VKHu0C/6CxfK8kqctMxR426V255afIyCsURzvIronU5qA66JVodlKXYcfMXX3edewxyllLUdQBdKCNVGkCt/IppDqW+DUwxww00jBuOcrLkiBoHTobBBzfg1h6AnQkeHQoFx5NGnIklkfxVS+ehF7yyhGEUrYguum/7asFBQaS5RLliDNw65oabCO0KJiUpz+Xf128EWPl7VX+FA3NFWfk5S1G8fQYFhIydw1PmLik1L7GkyMUE7OWes0JMdb/6IED5imFJh+9xZzVV72rz315+C8vtVZwljbXTIsJNr75xVxy+uB0C4hScnEbkJryA6vExCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCKNtCLU/3gzyExcAh1hKu0L3KGKBuuHLI6zD7lKb5g=;
 b=E6/Z6uLwgfqBCmsxpOTPq4I3KVr6+70BKVqshRtiUxARIDSC1MFRMJBGXWbIVrOjFDQm7JysMCv4KB4baQoPPCv76wdbmshjE/ah6QiOTTjQB0bK84MzWYsvEwOsLgxrYVZiiQKrdfIWDgIhpE4/cYI7w5BZhUT4oRZaoFtNPwt/f9gh1Qwlto2sk5Rn6acs+5w4hwtUPtm2wseqF0jpj8vzjJ/qIf//oBmThW0Xu6pCjyWsyrrtsxav1vTRcdHPYeJY9ESbYF443gkDzmrSBGtzmKUoOss3EmY5RfwzjxdM2GT4dW7p4R/x3/Ff3rOKa6O06fq6QAJxW/RhuquXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM (10.169.13.146) by
 CS1PR8401MB0535.NAMPRD84.PROD.OUTLOOK.COM (10.169.14.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.22; Mon, 12 Oct 2020 22:38:51 +0000
Received: from CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::141:f70b:ea9e:a1c5]) by CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::141:f70b:ea9e:a1c5%10]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 22:38:50 +0000
From:   "Manikarnike, Vasuki" <vasuki-ramanujapuram.manikarnike@hpe.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: librdmacm: cleanup/reinit API?
Thread-Topic: librdmacm: cleanup/reinit API?
Thread-Index: Adag5Df1zC6SM8fbR1aRdjHCAPFj4g==
Date:   Mon, 12 Oct 2020 22:38:50 +0000
Message-ID: <CS1PR8401MB0614C667E371DC6F8326CE4BD6070@CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=hpe.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [73.189.34.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3347fad0-7691-4dbb-9323-08d86eff976a
x-ms-traffictypediagnostic: CS1PR8401MB0535:
x-microsoft-antispam-prvs: <CS1PR8401MB0535ADF53DBE3F8D45665699D6070@CS1PR8401MB0535.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nqT/1gzKwKM+ka4UgE+5tvOQYqhZwVnRxRM0fZ7qTWSJQgy/ufySXQcz+yBAeqkUfuu/zSdu1GoKfryQkPrtckz0/Ne/ddHLiFlNHfyMHmFZ3nsmS5cScosY5CS9nfuxrhjU+rrArwIQugBVOwlGNXf986zX53ZDpSFauVxaZjgm/Y1+mIGvMkJW2H0hPgXVl/CZmgIB+It1iV9XxMSIJCsDvVv2koKKTOpN/6umZxGiSkgqhXwcrtLzIcR0yN9lNBhrSRQsOrUes3vbjNVEN2tf244Nx41JXoixv7PktQgSfnZ/NmhRBA8HXB1aYs/+6PULHy+nm9KWQ78+oI/IGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(136003)(366004)(396003)(186003)(33656002)(66556008)(64756008)(2906002)(71200400001)(55016002)(8936002)(66946007)(66446008)(8676002)(6506007)(316002)(52536014)(26005)(7696005)(76116006)(66476007)(5660300002)(9686003)(83380400001)(6916009)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: p5rTkPxoLp+UF9/9OeKY9HRjjq6j1TUPFUdMoZrzRzWk+ZnCzrUQHD+AAri2pbpJUx2swIX9lGDIKlK7deKK1IXzxD71IRcatN1RnQEnD9CY+0yzIoCiBerr5SvtDBurvYWXi5/QAcqJUze4k2evVJmjqEcgNcakcMZSu6eUx3X6s8V8+VrxMjYX6GVUb4WP2CUC/Xg5tw3BPrxXnf8f79WWoa7ShyXkHhR3mL31Rv9jJGT1DWZu7WTS9NX+RUez9+wd+k+3qWY3eVr+uDtcohFofIcaSagnYf1eq9gNSlmJnC8XmIN29i47QBbW/l9UVVo7D4ZKtWUJRUev7YjKWLr5J8TRWT9pp8SzDtBPF8Y+M58PL8uIZNu+PBALL4ZiWLSoSJU5EOnhqQJULDKtbjOK+IUh0ZMl+O2Wss/LrCeK6orJHRpzWYhbJNwrAo6kik1hLcI0+GfkFjV5J0gMtzIepWJPgb0h7tcWB5Ab8QL3F6wSiDAR4AbyU53d+DtOht5SliiJ04rgZnBHOpsibI91wiaBrJnx/SSaaJTKxKC5FBiyH/SyJvH4pQbqgkvqgTNEhiWRaB5TDGWmpVY9XXKDgdKba8V5FyNeFO5cxrHpp5gyRs9CzxAALfEo43nmC4iO4uDPzwzBWH4a3dGSCg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3347fad0-7691-4dbb-9323-08d86eff976a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 22:38:50.8115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/5ifAuSCdQRk9zMupSAPA+Z3rgdhVakJBcevvzWqjVzrDFGWCgTf4sPjCmCwc/0yTmI2bVLsOu8ueKHrf106LV53BMTjLj5TGgbMnj3zMgHseXZhIfv/R7i6/AfIR7wiEOIzyfARHdcoM9AMDabgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0535
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=889 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120165
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

I notice that librdmacm does not have a reinit/deinit/cleanup API.
I'm looking for ucma_cleanup(), sort of the opposite of ucma_init().

The first call to rdma_get_devices() from the application calls ucma_init()=
 if required.
ucma_init() builds the  list of devices, and subsequent library calls use t=
his list.

We'd like to issue a full chip reset on a Mellanox CX-5 adapter by using th=
e 'mlxfwreset' tool,
and we'd like to do this without requiring our application to be restarted.

Our application uses SPDK, and I notice that trying to probe for new RDMA c=
onnections fails after the reset.
The probe fails because RDMA address resolution fails.

The reset destroys the Ethernet interfaces and adds them back to the system=
.
The list built by ucma_init() is never updated, and library calls continue =
to use a stale list.

When the system is in this state, I was able to run "rping" and "ibv_rc_pin=
gpong" to the client.
If the application is restarted, the RDMA address is successfully resolved.

This points to the fact that the list of devices maintained by librdmacm is=
 stale and needs to be updated somehow.

I added a new API ucma_cleanup() which walks through the list of devices an=
d frees them.
I called this API from our application after issuing the chip reset.
After this all the RDMA address resolution calls succeeded.

I see that ucma_cleanup() existed as a destructor function at some point, b=
ut was removed.
Could you please throw some light on why this was removed?

Thanks!
Vasuki

System details:
OS: Debian 10 (buster) based
Kernel: based on RHEL 3.10.0-1062.18.1
Hardware: Mellanox CX-5 Adapter
Library version: librdmacm 24.0-2~bpo10+1
SPDK 20.07/DPDK 20.05


