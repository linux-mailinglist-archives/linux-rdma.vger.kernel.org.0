Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CC562FEF4
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Nov 2022 21:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKRUoS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 15:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiKRUoQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 15:44:16 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6B152896
        for <linux-rdma@vger.kernel.org>; Fri, 18 Nov 2022 12:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668804255; x=1700340255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KW2+2Y5Nr+Sp9rIRrSPvUufCYu5DFnEmg/aaE1vNJMM=;
  b=j8Xi0+XOS0aeNnWQ/ul/JzTg814m4B/IlEccr9Q/Rzz4b/6KfMI5fMQG
   IkURQdy19LgK5dv75Xnofm07PhAAPkGirZnpVbtj6HqJWk7BgdJxk6Icq
   sXf/87vfn1WYVzCC0Bun6uA1SRsIPzG/bkJIMvSVVhjXgMIISMFjwi6iE
   GJckVv/BrLCYemjeZD3faTTueObNvFYdSgUGc3o50/kfVviwlWR50Es7J
   TXHQcGqUHGIN/AIc8SVPQFvR+usjejNgkI3REaUIafgW/UygHM+dJLHm9
   8NrcJ6k1QWv4AYhLQsuEc6uYjWaQPgyJfsEqBM8s6L4kjOCyONq0Ty0Cq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="375372429"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="375372429"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:44:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="618140229"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="618140229"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 18 Nov 2022 12:44:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 12:44:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 12:44:14 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 12:44:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfJ/0vw6MhmTo3B2KBWfu6OIE/4e/XN1xV18W4XccXW2dARxmR2V/WzPGvg0OGAKNvRS3sRPZL75EhKVqq2FGJ6/phLdjGv+nnCF1gPHUBl9vQAFIn7Z8FTEv/MocexVcZ/TVtpyH44GVhISMmWh7085zx5OAK+ZYYSv2Q+j4apMooykU0AutXpov//sKaUgeOXGjyP4yI3eH6fO/9Ui6CeulfjqCWo03EiWOf+Yan2Thow6geSLtZCUid1CiuPVETRnWcYOe2OXwaeoq659uyrOvKKTvsHW+P4BsfO1v04+1B0JllXsApfniLauHUhClwARRrbugAip7UT2dVnYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5N+2YNMoKEoqnjg63i5+Dk1KlpjciJdVBl7jH64juQ0=;
 b=D8KYzr3o1a7rqRj3vvLg9hGyfTTiADiHw0f5cS3msJ0L+ZXIF3Z54GUZ9QYSzphHT9eRK9WDQ/M3kIGfeUswFGz60vuv9llo2h/AkwGtTeaLApDw2KwL+3tiEJ+d+CFCgX9Y0QxVlD//bwe2EFShn+eK2F6NjgbisZrocbpxn6FQJUXj2CuwPOenVnuVyhysWUoCQl7z0EVBstb/8+47CF0Rbs/32RJAEIa2XQYIINr19QnBKoIDegjdec4kno5iW0s0/lu6LoaFYG44JyRZ0eRA9l8WN49Z+ZZHcNhuAZKFDKyZ+I0gvb77Lud4jCh/dykoQ+SIS+K4KaE4UmRzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6403.namprd11.prod.outlook.com (2603:10b6:510:1f9::9)
 by DM6PR11MB4563.namprd11.prod.outlook.com (2603:10b6:5:28e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 20:44:11 +0000
Received: from PH7PR11MB6403.namprd11.prod.outlook.com
 ([fe80::b2d5:d5b7:a47d:65fe]) by PH7PR11MB6403.namprd11.prod.outlook.com
 ([fe80::b2d5:d5b7:a47d:65fe%9]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 20:44:11 +0000
From:   "Ismail, Mustafa" <mustafa.ismail@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Dan Carpenter <error27@gmail.com>
CC:     "Latif, Faisal" <faisal.latif@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [bug report] iwpm: crash fix for large connections test
Thread-Topic: [bug report] iwpm: crash fix for large connections test
Thread-Index: AQHY+maWy9zZC23n/U+SUkTvDQcbnq5FJdjQ
Date:   Fri, 18 Nov 2022 20:44:11 +0000
Message-ID: <PH7PR11MB640377FDDE4E242D31DE063E8B099@PH7PR11MB6403.namprd11.prod.outlook.com>
References: <Y3ORbHXv5M8X8kqN@kili> <Y3X91h5Fla+4mICY@unreal>
In-Reply-To: <Y3X91h5Fla+4mICY@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6403:EE_|DM6PR11MB4563:EE_
x-ms-office365-filtering-correlation-id: 09d4d727-bb9f-4bd4-128f-08dac9a5a5f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7zYXojuWw0LXQ5Cn5kABhayNsNNhOzXFO1lHf0SJoJEOu9aPTQFwftSj9IUBCP6lZjvTdgDxZUr2k6x3LW62A0q6h1HUGn8ykqJjaOwZL+D5UvkMTDHT4plkbQHE3QXmBSmSvSOnZpz9Iuu6vFKFj4H8y3WYo19aVmjzoQaoCtVvJ+D/NH17PXPu96c4PZ3bN8djs9+TfmZKUEINyHjWMoNy2daYZ1C+pTzAYuTgtU+UhiLGl92RxTBL2OmBwHZFEVDzXiK2KyPRRvAGbt7NBpcTW47p2STZKTq5pYDpU7Ze6OJkTi4a9OuPA6cPLgnSiqeduphZay0RnN2XZjvWlMJrTxNPEkV7DX68Wdfvvyj2tpvkULEciij0OyVBrwguacbVpIqCHcDOX0sKpYXL6rHaK5MnJIocPtjWq/BXP2U/YcbZ8rLVVRUskJB3EKFtenPq/y5UzgB5mx8u8A9HVtTDB5989Jh5qBkXJrE5+95GGfuyBFXuJgqpA+byq+CS1qF+//OsqD2lV5ZZjMnyRq7RHmXMRyp+dc4AxgaTsqy0hTVNqN3FgH7FmXVYVWD6qfoZYI7uBEZccwEqtI6Crb/5cah56DTyXOc6aeCH9SPXJ72rUY6PTiM8R1yIJOpUcTGg4/oZiQqhPJYcdv6p7RBUOH1vVBfbjtj/SYy9HXzP8IQ/Uad1HVdqnY8tPHUgBJ5IA3elBZPDcyw4BQLh/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6403.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199015)(186003)(54906003)(110136005)(316002)(26005)(4326008)(64756008)(8676002)(9686003)(478600001)(66946007)(66556008)(71200400001)(6506007)(7696005)(66446008)(76116006)(66476007)(5660300002)(41300700001)(8936002)(52536014)(2906002)(83380400001)(38070700005)(38100700002)(86362001)(82960400001)(33656002)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7ZUlY4+Fhuk75OlZ1LBEWoqfDL/teV1Zi0gRNN3p+ITXIPN1xn9+Fr0BxSGm?=
 =?us-ascii?Q?y/5YWDgrhuEbDIuEi6g5pHsbPkzSUk4WU5Clp01xm41137gHGbf6cVQLkJ01?=
 =?us-ascii?Q?efTFUS2vv+tFI+DwuG9HVLf/3XjItNJW+sWa6hSMJHqEGnH8gsotXEXbSMgy?=
 =?us-ascii?Q?4JeC6NmDfQoCPqu0aBD7+KP3ScKXOQqrHQrM2icnIH7SGlsqrkNJ2qMbcv1c?=
 =?us-ascii?Q?K4rcZiriQcTLOBIJ8QhBl4BaH+68ni35NAyzd2AZrakln1C8DVP5sKDdWIYh?=
 =?us-ascii?Q?AF3zQ0yzfx7TXgQ94pxfzvUulCD2WMVYBDf/edBYkJ4+u/ZPQSJeQEgK8gvP?=
 =?us-ascii?Q?OHsavlI0mkg/kfH3oyxD9Q0hWuG6M57EYazPxh248dzp3t1GsTdNv9lGQHqE?=
 =?us-ascii?Q?kCh1yMjwI8mxo/sWMqeHS0d/GBKX51CvnU1K0I7MmoA137daBQXKe/okieGU?=
 =?us-ascii?Q?Uy6/4eQw43ViHK3rily2qriX/Eax51ZO0CSOHmFGseklZX+K4sbmCSD7nC0R?=
 =?us-ascii?Q?f/PY4hQW1hLdn44CeP7ItcSNALBwIFe9ZWaQB02GDSrdx2Wr2KA+5qH6fO3a?=
 =?us-ascii?Q?SNa+5pfQEXqU9VWdgYSn8GInDU8ujKLOgfevVwjSsgQUxt2PcSGGIeCpTzh7?=
 =?us-ascii?Q?lqZCJxw5ConLJPh3XqBGdna1t32cn/3VwO4MCFfTTm/hXZzpUJWh4Uq/2s/e?=
 =?us-ascii?Q?2ivU3AjxpRRoPMgcTVoXI1BxwEZhRbmp8XNGdXv6Uf2BykOAMumTFKjxuq3V?=
 =?us-ascii?Q?HxBB7tLA621WeVYzcsoEYxUk6bjw06ZVc8t2gA5OEPb1kQGOnhFcAN1bcHwX?=
 =?us-ascii?Q?OfGOH8lIsPjv/lFRWBsgsEWo9cFwW/CwZSRzLEprcV2m31PNZNchB8yaz63/?=
 =?us-ascii?Q?Xld8GCMvGcRdKQxfO5rK/l3uMEls9HuEsgGPRGTzhqOx2NW1RauQbaxwDthk?=
 =?us-ascii?Q?4VNYPmSTVufjVO0DGEj5JgYb9W777bpG4PHdq/8MiAGPvqbQJXQk+t656rZy?=
 =?us-ascii?Q?oE3no3duZQsICuxajSaxCZwCahanAu6L23hWIPtaLHMVB3fl7nDyk6gAYHDg?=
 =?us-ascii?Q?DhoVm25CQH8aWBG1GSsbP0Hor274YRNIqDdgDhZ/xGiqDcnlo/eEo0jK2Dg0?=
 =?us-ascii?Q?+TgatyHelERhrzIuLt2Mvv1gWIZPrlCTynE+suM0R4OaLDG+cHobjpVvz4gF?=
 =?us-ascii?Q?rX4qSF5QS/x8SWDxpd9Ly7ftwW/oPq7XuoPy2aurKroAlTVaGjxFk4kvDV6k?=
 =?us-ascii?Q?nuz+/pTjFTy6aU04GooLmlF25Rz2gFOUnfZh8SycW56n8mP5chahDRjYpbgG?=
 =?us-ascii?Q?O4FHhvPkgXCqMEqKDn4rQHyxqNGZMVJfF1y8r2A7PSRv8L3Caih4xfdnXkqb?=
 =?us-ascii?Q?D0XdKfdEhsi6dX/VbjuuUrNJR9BwRi2Rqgb0NEMrdb5qRuTPxW4oR+ZCsBJd?=
 =?us-ascii?Q?AwJ9STi2BCMgTa/f8DrRElBsFcvWi976u1mSB9E5y2XfMWOMdBjQINtipTT1?=
 =?us-ascii?Q?8LbIWwCikryep//eGkfMxg6X1Gi8r2zTNcAFzHtMsDMKwJCMlUhfYYwQ3Hbv?=
 =?us-ascii?Q?CH0SheDJYDysyxxpvZtm+X3jWt6dhAA9lmHCjz2p?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6403.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d4d727-bb9f-4bd4-128f-08dac9a5a5f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 20:44:11.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmxTbNoLN0UELBzI/4ghNS2QDBgbOa0YoTuZQ2HVV1ovC2IYEn1fhORb7dg7yxXkFxsEjyCH+rFBBoSmSAEYCVuBz3PPrEFmfYfOL1t1IoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4563
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [bug report] iwpm: crash fix for large connections test
>=20
> On Tue, Nov 15, 2022 at 04:17:32PM +0300, Dan Carpenter wrote:
> > [ This isn't really the correct patch to blame.  Sorry! -dan ]
> >
> > Hello Faisal Latif,
> >
> > The patch dafb5587178a: "iwpm: crash fix for large connections test"
> > from Feb 26, 2016, leads to the following Smatch static checker
> > warning:
> >
> > drivers/infiniband/core/iwpm_msg.c:437 iwpm_register_pid_cb() warn:
> 'nlmsg_request' was already freed.
> > drivers/infiniband/core/iwpm_msg.c:509 iwpm_add_mapping_cb() warn:
> 'nlmsg_request' was already freed.
> > drivers/infiniband/core/iwpm_msg.c:607
> iwpm_add_and_query_mapping_cb() warn: 'nlmsg_request' was already
> freed.
> > drivers/infiniband/core/iwpm_msg.c:806 iwpm_mapping_error_cb() warn:
> 'nlmsg_request' was already freed.
> >
> > drivers/infiniband/core/iwpm_msg.c
> >     385 int iwpm_register_pid_cb(struct sk_buff *skb, struct netlink_ca=
llback
> *cb)
> >     386 {
> >     387         struct iwpm_nlmsg_request *nlmsg_request =3D NULL;
> >     388         struct nlattr *nltb[IWPM_NLA_RREG_PID_MAX];
> >     389         struct iwpm_dev_data *pm_msg;
> >     390         char *dev_name, *iwpm_name;
> >     391         u32 msg_seq;
> >     392         u8 nl_client;
> >     393         u16 iwpm_version;
> >     394         const char *msg_type =3D "Register Pid response";
> >     395
> >     396         if (iwpm_parse_nlmsg(cb, IWPM_NLA_RREG_PID_MAX,
> >     397                                 resp_reg_policy, nltb, msg_type=
))
> >     398                 return -EINVAL;
> >     399
> >     400         msg_seq =3D nla_get_u32(nltb[IWPM_NLA_RREG_PID_SEQ]);
> >     401         nlmsg_request =3D iwpm_find_nlmsg_request(msg_seq);
> >     402         if (!nlmsg_request) {
> >     403                 pr_info("%s: Could not find a matching request =
(seq =3D
> %u)\n",
> >     404                                  __func__, msg_seq);
> >     405                 return -EINVAL;
> >     406         }
> >     407         pm_msg =3D nlmsg_request->req_buffer;
> >     408         nl_client =3D nlmsg_request->nl_client;
> >     409         dev_name =3D (char
> *)nla_data(nltb[IWPM_NLA_RREG_IBDEV_NAME]);
> >     410         iwpm_name =3D (char
> *)nla_data(nltb[IWPM_NLA_RREG_ULIB_NAME]);
> >     411         iwpm_version =3D
> nla_get_u16(nltb[IWPM_NLA_RREG_ULIB_VER]);
> >     412
> >     413         /* check device name, ulib name and version */
> >     414         if (strcmp(pm_msg->dev_name, dev_name) ||
> >     415                         strcmp(iwpm_ulib_name, iwpm_name) ||
> >     416                         iwpm_version < IWPM_UABI_VERSION_MIN) {
> >     417
> >     418                 pr_info("%s: Incorrect info (dev =3D %s name =
=3D %s version =3D
> %u)\n",
> >     419                                 __func__, dev_name, iwpm_name, =
iwpm_version);
> >     420                 nlmsg_request->err_code =3D IWPM_USER_LIB_INFO_=
ERR;
> >     421                 goto register_pid_response_exit;
> >     422         }
> >     423         iwpm_user_pid =3D cb->nlh->nlmsg_pid;
> >     424         iwpm_ulib_version =3D iwpm_version;
> >     425         if (iwpm_ulib_version < IWPM_UABI_VERSION)
> >     426                 pr_warn_once("%s: Down level iwpmd/pid %d.
> Continuing...",
> >     427                         __func__, iwpm_user_pid);
> >     428         atomic_set(&echo_nlmsg_seq, cb->nlh->nlmsg_seq);
> >     429         pr_debug("%s: iWarp Port Mapper (pid =3D %d) is availab=
le!\n",
> >     430                         __func__, iwpm_user_pid);
> >     431         iwpm_set_registration(nl_client, IWPM_REG_VALID);
> >     432 register_pid_response_exit:
> >     433         nlmsg_request->request_done =3D 1;
> >     434         /* always for found nlmsg_request */
> >     435         kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request)=
;
> >
> > The iwpm_free_nlmsg_request() function will free "nlmsg_request"...
> > It's not clear what the "/* always for found nlmsg_request */" comment
> > means.  Maybe it means that the refcount won't drop to zero so the
> > free function won't be called?
>=20
> I think so. The nlmsg_request reference counter is elevated when it is fo=
und
> in iwpm_find_nlmsg_request(). So I assume that it will be at least
> 2 before call to kref_put(). Most likely, nlmsg_request->sem prevents fro=
m
> parallel threads to decrease that reference counter.
>=20

I agree with Leon. The ref count should be 2 here.
However, I don't see why the kref_put() can't be moved after the up(&nlmsg_=
request->sem) to get rid of the warning.

Regards,

Mustafa
