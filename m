Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4FB0FFA
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 15:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfILNbO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 09:31:14 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:14914
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732166AbfILNbO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 09:31:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkLs6bNVcRJrnERvAU9KujVmrVvGjUrnHss1sexQi7a5P/+6cRn12C8ApwnoEDkFNmubYXzjKiDcvY2VYV2MXTO04TyY8bufXDsf27oQMY+gWaUTu82Msy0/j+L6XLVHSfm5nk+IEMO7YMoX3H9kZ0UNlTPQa1oIlbRXxVmRjAq/NutnjFGZgwBkmwTXXinOCfE+Nkl3rggHF4y52eLwFJVgJRojhQDPmv8xeahYMoaPvIUwfeqwAB9+n53ZVlI03tW9Z+Wet0BcccuuXl3JUJyKzxfPJjzvjYyaMm/ByD1WHOkvAPko8kPUZy+Q070iq0mY0N9+4RSsR7X2SESEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD3NOALZj1epQP0BrKna9gwqJPqs9pgVDCPc3kjl3Q8=;
 b=ZYwQB7acBQr0ocxQU3QlpSLjmsFLUCALNHi/pVpgBA8m5nSfiQH7mczxb4AifT8Dia8JhqW0FTjSZs+6SMoFxcUAOc7Dddl5N4oJ7Rarh1Jv+IFavucg45hYmS+QtPM0viANBxlg2mg9XgrATu+yiHqP6yfpIdxqPmYI7+TYjuIFCLwZ3MwY5iS5xn5nW8Aul5yTHH4oKdd+9JfBOs6vkJUsIagLinwoNtBgkLYNzX0qhgnY4cfgWleECBq7J34wtcnsQOvmx7j6mKvSPzllCD5izgjrhs6etRH+dP2W4cOD09X6kc7DkA1n91i2HHTfBnHvtuC9Y8V2KLZ1RS01YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD3NOALZj1epQP0BrKna9gwqJPqs9pgVDCPc3kjl3Q8=;
 b=CYOz2jOzuIHr9YoeVEF9Fdm2iReC/PDCR7xoWyjW3ieztpdAZAg3ggoMEDDzv0FSPv5QRS7WKtuU+6BYrJbINQlCcFsfFKUYh9MC+uy3f6fzfQenN29/+DhDgwBN3wUUMVC5YtgsKwrNP/mjmTsTkoramp8FmbIXY9q4QX97im8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6221.eurprd05.prod.outlook.com (20.178.124.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 12 Sep 2019 13:31:11 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 13:31:11 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] kernel-headers: Update comment to reflect changes
Thread-Topic: [PATCH] kernel-headers: Update comment to reflect changes
Thread-Index: AQHVYuQC32KnJMGEtkaMXJpOGcQqpKcoFtWA
Date:   Thu, 12 Sep 2019 13:31:11 +0000
Message-ID: <20190912133057.GA19091@mellanox.com>
References: <20190904054530.4391-1-yuval.shaia@oracle.com>
In-Reply-To: <20190904054530.4391-1-yuval.shaia@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:5:60::14) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1429895f-217f-4ac9-cc81-08d7378579da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6221;
x-ms-traffictypediagnostic: VI1PR05MB6221:|VI1PR05MB6221:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6221BA93312AFBD9AD8D7AABCFB00@VI1PR05MB6221.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(386003)(66556008)(66476007)(64756008)(66946007)(6506007)(476003)(26005)(6916009)(66446008)(99286004)(66066001)(102836004)(52116002)(14444005)(76176011)(71190400001)(256004)(54906003)(71200400001)(2616005)(446003)(11346002)(316002)(4744005)(1076003)(5660300002)(86362001)(305945005)(486006)(36756003)(33656002)(186003)(7736002)(8676002)(3846002)(478600001)(6116002)(6486002)(25786009)(81156014)(81166006)(14454004)(53936002)(229853002)(6512007)(2906002)(15650500001)(6436002)(4326008)(8936002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6221;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IFyU3zPuh9bupT27g8IlUYnNnPqarRZ/AMXlBuA3vwRBWeA1urVcPRBbDJxltZLpFI6+nEPxh+hfqeDDOGUoqsyaQMV05yBPNPm9bkDWFHLb6x/UimXXtwJU+GfbG2d/7eWJW3sux5oNA9I/qxGmeBpziztCPrCLB/rMGCY87VxOPmS2HsoCu0VxZ6X9dCpNzetOXmPHdRL176a2ll4BwYxWiDICylq0bmm/CkjuSbO3kc37SLjUdlyFEZrzPi/JNHhosAWDL2DRWQ/iXmlB4V8MBkTeOemZ+0QQRKLmsAmV7FJZbsujMOJGKuU9UPmN2Gl5A+SRxm7COqjytUiuE6wGImADO1DUCcaZGd7utdjTwh5SbUliPZ4raXWcIIJlhHdTMxLnty0F272X83wrBPN7AQvSkTxp4SHf1EAllxQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F4E17563F9D5349BA89308B570CE590@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1429895f-217f-4ac9-cc81-08d7378579da
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 13:31:11.3233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nrWvoOiJG9/eaNGgVMRTa8uxF99aqjWS4Nm6AuRiYUntD8GTN1nMYolYVneod0TTXAak3L2vSrk/vROcHDzqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6221
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 04, 2019 at 08:45:30AM +0300, Yuval Shaia wrote:
> Following change made in commit 08536105d93f ("docs: ioctl-number.txt:
> convert it to ReST format") change the comment that refers to
> ioctl-number.txt file.
>=20
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  kernel-headers/rdma/rdma_user_ioctl_cmds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

rdma-core kernel-headers/ is automatically sync'd, this will come the
next time someone needs to update it.

Jason
