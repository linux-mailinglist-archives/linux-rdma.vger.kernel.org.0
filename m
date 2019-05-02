Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75EF2121BA
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 20:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfEBSOe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 14:14:34 -0400
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:49566
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726091AbfEBSOe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 14:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haGy3Jk0B5T/Y81J3OgKl7yIKh84NwRNLxhgIniAmKo=;
 b=tCgwQUqZYvwZfuiJlSFvQvdjGqT3MUv62ghu9gqbiVxBSL3Z+zraT+fwB4nDuNVazO/fDKwgViZo0n7xh3rCyRfUdlU9+ki32P1BpXkWJu/oll69xVc/+g7fAO0b9i5hE29Ir7aKVy98HhJsxuMfq6F7DH5g4vPifbAyjcvWI44=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6000.eurprd05.prod.outlook.com (20.178.127.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Thu, 2 May 2019 18:14:29 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 18:14:29 +0000
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
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Topic: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Index: AQHVARLft6YhcNgq2U2bxKGl+U/wYQ==
Date:   Thu, 2 May 2019 18:14:29 +0000
Message-ID: <20190502181425.GA28282@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
In-Reply-To: <1556707704-11192-11-git-send-email-galpress@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0022.namprd15.prod.outlook.com
 (2603:10b6:207:17::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8760bb4-6f29-455c-2ac2-08d6cf2a04ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6000;
x-ms-traffictypediagnostic: VI1PR05MB6000:
x-microsoft-antispam-prvs: <VI1PR05MB6000D6DBDF7FCD416E17164DCF340@VI1PR05MB6000.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(66066001)(99286004)(2906002)(6436002)(52116002)(54906003)(229853002)(6246003)(8676002)(81156014)(81166006)(76176011)(6506007)(86362001)(316002)(4744005)(53936002)(186003)(476003)(6486002)(305945005)(486006)(36756003)(386003)(8936002)(68736007)(5660300002)(6512007)(7416002)(33656002)(25786009)(3846002)(14454004)(6116002)(478600001)(1076003)(26005)(11346002)(66446008)(4326008)(73956011)(2616005)(71200400001)(446003)(102836004)(71190400001)(256004)(6916009)(66946007)(66476007)(66556008)(7736002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6000;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ff84bQ+IqW1vBpx1s2hXQ2xJWAIRLe91h6O0OfAGcYn/tkXNKF+fuaLQ4d+7MhvCNh4OolXVWh0rkvB0shYfywg8piQS31Tx+zo4u97EKP/6KlhMOloJkma6hZsCV+URGppWKyX22G4UMXFNxRIZUdvEd9m5qrbZLidZuH4J3FAAqO7oLYR+hLTB9TBw7bMw9omdbqCet3KV+yfHT3zov3xe5ExzHx4HrE5/vhLFCmeWXI+p0umCx4JTnRDR16pTTjI6ryTHzaEQ87iTB4x5CyChpRTEA/yOawuLBULwSqZ0rIB27bDIYk1abMyiY6cWxifp0WEedsEvvId667QfyS0olzRbKKzTixxYBnqPuWMFrlZnNfbHOCFJ7WkDgzW9sDwo26En+yB+MWKuwPwo2sZkoyBMQm/CF5U9X1i08OE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6156C3E35CFC7D46A7518E01B7595D34@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8760bb4-6f29-455c-2ac2-08d6cf2a04ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 18:14:29.6009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6000
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:

> +/* create a page buffer list from a mapped user memory region */
> +static int pbl_create(struct efa_dev *dev,
> +		      struct pbl_context *pbl,
> +		      struct ib_umem *umem,
> +		      int hp_cnt,
> +		      u8 hp_shift)
> +{
> +	int err;
> +
> +	pbl->pbl_buf_size_in_bytes =3D hp_cnt * EFA_CHUNK_PAYLOAD_PTR_SIZE;
> +	pbl->pbl_buf =3D kzalloc(pbl->pbl_buf_size_in_bytes,
> +			       GFP_KERNEL | __GFP_NOWARN);
> +	if (pbl->pbl_buf) {
> +		pbl->physically_continuous =3D 1;
> +		err =3D umem_to_page_list(dev, umem, pbl->pbl_buf, hp_cnt,
> +					hp_shift);
> +		if (err)
> +			goto err_continuous;
> +		err =3D pbl_continuous_initialize(dev, pbl);
> +		if (err)
> +			goto err_continuous;
> +	} else {
> +		pbl->physically_continuous =3D 0;
> +		pbl->pbl_buf =3D vzalloc(pbl->pbl_buf_size_in_bytes);
> +		if (!pbl->pbl_buf)
> +			return -ENOMEM;

This way to fallback seems ugly, I think you should just call kvzalloc
and check for continuity during the umem_to_page_list

Jason
