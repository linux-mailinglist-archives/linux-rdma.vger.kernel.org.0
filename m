Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF8C11A8E
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEBNzQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 09:55:16 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:47527
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfEBNzQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 09:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCErm6vWP8lFVhheITY/m3rWkw0qVd7HxfPNWdjWf90=;
 b=LhQHCwLlOTBaZEilAQRWnnHlBvAAB4KL8LiaqEI9Wz82LzmqHk1W/oPKinjzJUBgxPu9XXDu2b2qy86OBR/hEbyefxUDFJIwmgoVgfQP78+r+/xJsGcmTvQ4ifmTDiYF29VyS6OSiMQ7Nkm1kQWBLCFfY5jd5iqDP/tNBUOAnnk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4367.eurprd05.prod.outlook.com (52.133.13.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 2 May 2019 13:55:11 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 13:55:11 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v6 08/12] RDMA/efa: Implement functions that
 submit and complete admin commands
Thread-Topic: [PATCH for-next v6 08/12] RDMA/efa: Implement functions that
 submit and complete admin commands
Thread-Index: AQHVAO6oZKZjenSic02yv/P2+LA/dw==
Date:   Thu, 2 May 2019 13:55:10 +0000
Message-ID: <20190502135505.GA21208@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-9-git-send-email-galpress@amazon.com>
In-Reply-To: <1556707704-11192-9-git-send-email-galpress@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:208:134::22) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf0c4590-5714-4c21-2d55-08d6cf05cae2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4367;
x-ms-traffictypediagnostic: VI1PR05MB4367:
x-microsoft-antispam-prvs: <VI1PR05MB4367F63323169F83A2F3E9ACCF340@VI1PR05MB4367.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(199004)(189003)(2906002)(8936002)(386003)(36756003)(3846002)(6506007)(81166006)(4744005)(14454004)(186003)(76176011)(71190400001)(71200400001)(81156014)(25786009)(102836004)(6116002)(99286004)(6246003)(86362001)(68736007)(52116002)(8676002)(7416002)(7736002)(305945005)(66066001)(6512007)(14444005)(2616005)(446003)(26005)(73956011)(486006)(256004)(4326008)(11346002)(66946007)(316002)(476003)(53936002)(66556008)(66446008)(64756008)(6916009)(1076003)(33656002)(66476007)(54906003)(6486002)(478600001)(229853002)(5660300002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4367;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0/5f8eciLGs70SVo04fUXvpJ2LGuZdCPix9vAe2tclPCanf9wP4G8Pm0ywqN4VuX3vZbeCa/2yOlGmtUx5y7uisKQL2y/QqQT8msTWixVapu2QgEsmY+OIJ2T5pygUmT9z6o9o1KnaQcELg+6gbyIeFaUTShAW3a4YlYhRvC0p3p1hHlDZVbR5e71kzEyKzicG2ExPO4FlToKUZlnCXYY4LzSWQgjnsepSsRRD9D05F8oe9fifOxVC4xu69a6kOovCWZOlPxbnkmPJBoeBnDRJ9MCm+ftvUvrZAW+PcQ++aoc4BpJbMK+sGtKzVlFn1oIxulYbFwGsnLTXGnP4ydQDXXCq3zHj7hNDL2ja0cnTZgieWmN8gJM7Q59WBGwBX1Ve/qn3Op/RbEjKKc9SJSjDbjjTeL5uVen9wLOvl8Ofg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <118B25AA718F394A92964EF3DB81E4CC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0c4590-5714-4c21-2d55-08d6cf05cae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 13:55:10.9443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4367
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 01, 2019 at 01:48:20PM +0300, Gal Pressman wrote:

> +static struct efa_comp_ctx *efa_com_submit_admin_cmd(struct efa_com_admi=
n_queue *aq,
> +						     struct efa_admin_aq_entry *cmd,
> +						     size_t cmd_size_in_bytes,
> +						     struct efa_admin_acq_entry *comp,
> +						     size_t comp_size_in_bytes)
> +{
> +	struct efa_comp_ctx *comp_ctx;
> +
> +	spin_lock(&aq->sq.lock);
> +	if (!test_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state)) {
> +		ibdev_err(aq->efa_dev, "Admin queue is closed\n");
> +		spin_unlock(&aq->sq.lock);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	comp_ctx =3D __efa_com_submit_admin_cmd(aq, cmd, cmd_size_in_bytes, com=
p,
> +					      comp_size_in_bytes);
> +	spin_unlock(&aq->sq.lock);
> +	if (IS_ERR(comp_ctx))
> +		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
> +
> +	return comp_ctx;
> +}

[..]

> +static void efa_com_admin_flush(struct efa_com_dev *edev)
> +{
> +	struct efa_com_admin_queue *aq =3D &edev->aq;
> +
> +	clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);

This scheme looks use after free racey to me..

Jason
