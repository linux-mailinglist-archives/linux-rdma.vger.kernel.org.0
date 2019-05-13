Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0154F1B00E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2019 07:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfEMFq1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 May 2019 01:46:27 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:59271
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbfEMFq1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 May 2019 01:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKCbAHSgyq9fM/AGzY7npMZrEyRyNGwvovPGiVYZEwk=;
 b=JaXf+8bJQhpeiKUKs9TR6DERleOWj/g7espZ9XIZPITD95GwJNZ1fjteuwa2eA7r7sUgOktetmQRhV4JVVA/vrJt2YDRtnyV7B/bUmtIKh/MCnk7IPu7oEKB9I2I00o89Bw5uQPSxeNhk7tGlCmxL8GHYOuo6UbdM78Z+vmaMzw=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.186.14) by
 AM4PR05MB3234.eurprd05.prod.outlook.com (10.170.126.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.24; Mon, 13 May 2019 05:46:17 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::74f5:6663:e5fa:3d6a%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 05:46:17 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/core: Change system parameters callback from
 dumpit to doit
Thread-Topic: [PATCH rdma-rc] RDMA/core: Change system parameters callback
 from dumpit to doit
Thread-Index: AQHVCUyD1KcGlKfwIEaR3l19n4pTKqZoi8EA
Date:   Mon, 13 May 2019 05:46:17 +0000
Message-ID: <20190513054614.GF6425@mtr-leonro.mtl.com>
References: <20190513052657.31436-1-leon@kernel.org>
In-Reply-To: <20190513052657.31436-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::20) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:3::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.3.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 642c6967-e112-4685-1743-08d6d7665186
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM4PR05MB3234;
x-ms-traffictypediagnostic: AM4PR05MB3234:
x-microsoft-antispam-prvs: <AM4PR05MB3234EA8097AC6370A7F0F119B00F0@AM4PR05MB3234.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(366004)(346002)(136003)(199004)(189003)(52116002)(76176011)(110136005)(386003)(54906003)(6436002)(25786009)(6506007)(6486002)(8676002)(81156014)(81166006)(229853002)(8936002)(1076003)(2906002)(186003)(14454004)(486006)(26005)(33656002)(11346002)(476003)(5660300002)(86362001)(446003)(478600001)(256004)(6246003)(66066001)(9686003)(102836004)(3846002)(6116002)(71190400001)(4326008)(71200400001)(64756008)(73956011)(66446008)(66946007)(53936002)(66556008)(6512007)(66476007)(316002)(305945005)(68736007)(99286004)(7736002)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3234;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xdZa7AgyBNSM9fEwMeoaQQEt/k7VXDRCMEIC/HMzIPjiNgCVRE0rphyI3PPKoeEunFMNZvSt5jnXX6eh1lOdv8glDkatYef6jhZtYhjE6bz6rZj/k0wcJ7GTfQCGY8K6Uzm2l7ZN1HN97JA1iWRUfM1TBTceZbV9UlUsSXhQM4npfJ5irYk6wVubMGz8TvmrX3IB5eI87/sgPboMGsGyTejzYsG0YKgt1zChbavl8a+7DrohBnm5qLRCtCgXmKovNJRt5hlv+HVAHiBLLrDE3vFun8lr6xJjMLk+HZPsJuZdWsLqlpuEdWRWArS9Q7DbFq791NReEoM2+vqTFK7CtjRLhVvfILfBS4odE+wgqPd+4fwrPoePnCJY6pje8LyncHla4OEZbZWlOnE5eyy5dS/aSw2Rx1+mt9ZkVgLH63w=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A091ED93D1DA3945BC45E811F4700C4F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642c6967-e112-4685-1743-08d6d7665186
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 05:46:17.7669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3234
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 13, 2019 at 08:26:57AM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
>
> .dumpit() callback is used for returning same type of data in the loop,
> e.g. loop over ports, resources, devices.
>
> However system parameters are general and standalone for whole
> subsystem. It means that getting system parameters should be doit
> callback.
>
> Fixes: cb7e0e130503 ("RDMA/core: Add interface to read device namespace s=
haring mode")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Jason, Doug
>
> It will send extra complexity with kernel-headers updates

send -> save

> if this patch goes as part of second PR to Linus in this merge
> window.
>
> Thanks
> ---
>  drivers/infiniband/core/nldev.c  | 27 +++++++++++++++------------
>  include/uapi/rdma/rdma_netlink.h |  2 +-
>  2 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nl=
dev.c
> index 46c0ec97aa53..7ce3a6b7a936 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1508,32 +1508,35 @@ static int nldev_dellink(struct sk_buff *skb, str=
uct nlmsghdr *nlh,
>  	return 0;
>  }
>
> -static int nldev_get_sys_get_dumpit(struct sk_buff *skb,
> -				    struct netlink_callback *cb)
> +static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
> +			      struct netlink_ext_ack *extack)
>  {
>  	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
> -	struct nlmsghdr *nlh;
> +	struct sk_buff *msg;
>  	int err;
>
> -	err =3D nlmsg_parse(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
> -			  nldev_policy, NULL);
> +	err =3D nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
> +			  nldev_policy, extack);
>  	if (err)
>  		return err;
>
> -	nlh =3D nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
> +	msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	nlh =3D nlmsg_put(msg, NETLINK_CB(skb).portid, nlh->nlmsg_seq,
>  			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
>  					 RDMA_NLDEV_CMD_SYS_GET),
>  			0, 0);
>
> -	err =3D nla_put_u8(skb, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
> +	err =3D nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
>  			 (u8)ib_devices_shared_netns);
>  	if (err) {
> -		nlmsg_cancel(skb, nlh);
> +		nlmsg_free(msg);
>  		return err;
>  	}
> -
> -	nlmsg_end(skb, nlh);
> -	return skb->len;
> +	nlmsg_end(msg, nlh);
> +	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
>  }
>
>  static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *=
nlh,
> @@ -1929,7 +1932,7 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA=
_NLDEV_NUM_OPS] =3D {
>  		.dump =3D nldev_res_get_pd_dumpit,
>  	},
>  	[RDMA_NLDEV_CMD_SYS_GET] =3D {
> -		.dump =3D nldev_get_sys_get_dumpit,
> +		.doit =3D nldev_sys_get_doit,
>  	},
>  	[RDMA_NLDEV_CMD_SYS_SET] =3D {
>  		.doit =3D nldev_set_sys_set_doit,
> diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_ne=
tlink.h
> index aaeeb0a8aec6..03694f4b5e18 100644
> --- a/include/uapi/rdma/rdma_netlink.h
> +++ b/include/uapi/rdma/rdma_netlink.h
> @@ -250,7 +250,7 @@ enum rdma_nldev_command {
>
>  	RDMA_NLDEV_CMD_PORT_GET, /* can dump */
>
> -	RDMA_NLDEV_CMD_SYS_GET, /* can dump */
> +	RDMA_NLDEV_CMD_SYS_GET,
>  	RDMA_NLDEV_CMD_SYS_SET,
>
>  	/* 8 is free to use */
> --
> 2.20.1
>
