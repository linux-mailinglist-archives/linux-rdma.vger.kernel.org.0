Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B4574D25B
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jul 2023 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjGJJ5b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjGJJ5T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 05:57:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6864C02;
        Mon, 10 Jul 2023 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688982831; x=1720518831;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E2IK45v9icWY1i6ACfQDVoL1dWsBiiU69FEJa8Njl7Y=;
  b=EyekJg+Lj53rHS9fDXJDTBLcWoHsnXX6A+YIYiN7wfWb9yBLNXhvHc14
   H3IvNjNiVnWwiASThCDLOwdy/XbaJtsE2XsZn7di7WZUKJlxkIslqJoz3
   FNzOITgfMBYn4jPxoTD+fHRcRzlISFoSWk4F07OpsnPtW+rHO3NUF1b7N
   5WQoZ/d9PNeeYW7nsNnD7dQM62CnpHYq5CeSh4AimFV4n56nXLajILZkp
   QuZ6GY7TEKYNEfgdIPr5ghI3RNtUr3MPT0kfcU3oEKyn/V83pPH5AthAU
   k9k3/proVT/TMYMIdphwERMhF+JrPNm+Q87aBrKaJJpYqSUsrG3ujZbsG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="349102722"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="349102722"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="865287182"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="865287182"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 02:50:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 02:50:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 02:50:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 02:50:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 02:50:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZ7+tSuMTS03pCs3yra0lAb0BLoctzFad0oqEfHOVijHefqsWtzZ9nzZNFrom2UJrhXzHRG/+KXQfMiRV3rZ96u+y6TrgvQWTAPfQFPJS0tUkJITjwh4qAj/gt5cay31NNANc8N68P7Pwp3EY/xOMG8VKcOVWVcAHeCoyREgH4zq+xuHsgkef7DE/lHe2TjFCoV3pPwfQw6ztB2c9sDQAli4gt4g1T39CeH4BjNW59g81viiQVQR3uMzou+eCLBA0UY8An1m2tcwtYvsyuvHmbKfDYIgk5VW3zPplTREYglsufAshYlZt4MB45QcswOgxDszFXTtPH0PCfXFDtXtxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGl7+6ORT2MpiMtxV5Fdnf7mAPRi1F8jNJ2IGE11weE=;
 b=bKmuFWS+SXJ8ls8aqbF5E/a8NH1vudAFk1joo4hFenNyQeT7MHIIcQee+wuem58f4I6FGAChEl3J/3y/gZGG2jmF/S42h3nxfFsyrRZqmb5VcVXpkcxEy4053JDidVZaBQB+FDM3CiHZ8c97l67QOwDsgpqJH4BebTSPsiVsnc4qANdEuDsdsFhBTwCtl+nnvkNP72rrlnegCY1C636Hn5K2CZKFAAa65zfN84qeGK6p2hss/Yiaa36cpV+/7oN/IYd5qp2OKpfx1kaW5gL4SxpUt8U3SlnpxBCjXwBFtY+5WB4rM3rKFYaW6XkzAFxgMzld25MImaHbgOfhwDPTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 DM4PR11MB5325.namprd11.prod.outlook.com (2603:10b6:5:390::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 09:50:48 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:50:48 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     Jiri Pirko <jiri@resnulli.us>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "vadfed@meta.com" <vadfed@meta.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "vadfed@fb.com" <vadfed@fb.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "M, Saeed" <saeedm@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "sj@kernel.org" <sj@kernel.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "ricardo.canuelo@collabora.com" <ricardo.canuelo@collabora.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "Michalik, Michal" <michal.michalik@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jacek.lawrynowicz@linux.intel.com" 
        <jacek.lawrynowicz@linux.intel.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux@zary.sk" <linux@zary.sk>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "Olech, Milena" <milena.olech@intel.com>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "andy.ren@getcruise.com" <andy.ren@getcruise.com>,
        "razor@blackwall.org" <razor@blackwall.org>,
        "idosch@nvidia.com" <idosch@nvidia.com>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "phil@nwl.cc" <phil@nwl.cc>,
        "claudiajkang@gmail.com" <claudiajkang@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>,
        mschmidt <mschmidt@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [RFC PATCH v9 03/10] dpll: core: Add DPLL framework base
 functions
Thread-Topic: [RFC PATCH v9 03/10] dpll: core: Add DPLL framework base
 functions
Thread-Index: AQHZpc/+2+ilbDjNIkao6LxAthBNeq+hd5yAgBFjgzA=
Date:   Mon, 10 Jul 2023 09:50:48 +0000
Message-ID: <DM6PR11MB465793F80239C1C87F1C095A9B30A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <20230623123820.42850-4-arkadiusz.kubalewski@intel.com>
 <ZJ09N2TI4wHrA4rB@nanopsycho>
In-Reply-To: <ZJ09N2TI4wHrA4rB@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|DM4PR11MB5325:EE_
x-ms-office365-filtering-correlation-id: ae91bff2-2a2c-445e-757e-08db812b239e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: igSfhPum8FbdzVZGmzgEYpxDi88X0xPLqsFo6bdHHyhxsaIcLXfq0YvUPIycpGUkIVAhx4HxzDNpCcBxa+1jCiaTpBgtI/Eh0OD76U7XeAIeH1m12SaudbJ7YbIuOmYnZzDji2w+2Q0Ayw4kLgMzNcSDvtj/OQz+aZfEZNE8VD9r2MVC84A/lYYJCOzOD13h8Mh6MBU5zC+BqdkR6T+lYP3lqbHGPD2PqiH9u4/0CnT/EOnPhgk1q5X4x65iihV6iMBHtx48wXiMMmdzPn+25T2QKUPSHoq1fhKrXrtMh1CnlvTK3ciFNPhHJQ3Z7L5wn4gKr1h7Uc1iaN1ZsYTDmkF1IlP8TPsDuch0BNCd2Rxp4PBUKbEnNHyId64NhPX7e/rmyqqE/ELnFDoVKGKYwOlngEFRIqp2IWgLgmf7il8ITiDroVRE8TA1c2KKbKw765ZM0lR9ADqGA+D/rw9KD0gkXHjauJiffS1VWmX8eiLesx/d++WtL/blbt8o7qPRUvlWtw31k3x541chPAcNWafNXXE+sTbb4krewImnnYPV4dANJfRaxnNyVG7fuQILgu0rWbFtOZfgK+/cdvHN+aFbltjiQWgdXn2GbTQR1w5cXdPS8mHydaaHsjDKGeP+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(186003)(9686003)(26005)(6506007)(83380400001)(41300700001)(4326008)(64756008)(66446008)(66476007)(2906002)(66556008)(52536014)(316002)(7416002)(5660300002)(7406005)(8936002)(8676002)(6916009)(478600001)(66946007)(7696005)(76116006)(71200400001)(54906003)(55016003)(33656002)(122000001)(82960400001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uV90vHJJqg7yEP4wn2MQD1viUa+a6TEFMAi3sWQFCGKBscG+Ru6I13Lv7bpf?=
 =?us-ascii?Q?QKfJPpGWNJcTsqgTAMKG3KBwBkprDCHBGzeWJkqY4EZ9OJziRPrZ1EDJPkAZ?=
 =?us-ascii?Q?ek52iJzaehs7kAaqvKayT51IlnB1JyilVFvX3nV+qSF7duPqd6A7zjUDO62k?=
 =?us-ascii?Q?EwyCBbwLuOzW+SQsz6OKlmm9wS3I8tTJq5BtsOFyR84mDcG0/1Iwr/Tdwz3f?=
 =?us-ascii?Q?rR+ZPJZ4G4WNLT2vPyz2nHHjX03uwcFk21Rs5QuKtN4MQhSS0WMwb3wmafQy?=
 =?us-ascii?Q?nHZvS7z56GxhQU/8Kp2hqP6y0yq1K4W9wKq0NPOM0cVOVnWHXJEFMzc1oUP/?=
 =?us-ascii?Q?1r5ap3fG7u1xKveACpW13JS3bucGjpPv1BsCx1oJVq9oPmsExVkYlP0WOAmR?=
 =?us-ascii?Q?NSoeg7uQbO76gLWnduV3r+UgYmcqDDd3raQyC4sJd/OcR00wHq4QQxu66p4g?=
 =?us-ascii?Q?ftfm7gdk9Zj6LF+Dqa/RXL+pC9AYQXqkM4QbW1Nf3fBWxwDZbZTYmYextKGU?=
 =?us-ascii?Q?5PC/i1o2pP6kllWCZkKtGg90zYIzv80EJ1llRPYmQa1UGxNsDqNuE7k7zVCb?=
 =?us-ascii?Q?XD/TdM59I6rXSqsRaQWt3o0Rc3ruU21uZ7M08zS3DSc1Re+NRRjfTAijbwzz?=
 =?us-ascii?Q?y/YWPru1wytv/dEVmq+ZHS8qis3qIQdIob6s5aWFEHfgw8u5ve2nUvuo/aet?=
 =?us-ascii?Q?VHGbVh7J7I2Dam8ra7AifHqQx6KOnwLIoTZH35dWNeOJ8FUizcfX6bc9cyzq?=
 =?us-ascii?Q?XNk6ZYGPOiw31jQyqdmOZGNIbvsC9A6t0t02rYrPvr6CfIFws7Lws6KcUO+v?=
 =?us-ascii?Q?L2snShiW18L2di/T71AlNNPMedOrbaJkK4PqtbKg0YWPETP3bRR56GS5UWUs?=
 =?us-ascii?Q?bJv1bZd89BymITfa8C+lhV/4jY3vsG5b8vvmIXqTwJDLfDScXWv72Tg0fhju?=
 =?us-ascii?Q?Ay4A+eprJIepSigFJ+eayMXHQFHcF9Z9pC5Uy/4gruthsz/Z/llMvN69Y7Lc?=
 =?us-ascii?Q?VSw1L9QYTirZ4OLhXPHNA1xmbWrrBaL9ezFvXY+vg7pML+z0GRoEAnlNsn7r?=
 =?us-ascii?Q?9Fk6c1h9+NWEARvuC7FRA6dZdB3vQbflfL1yzmilqP3eU8R7VRk+j/pH2KMQ?=
 =?us-ascii?Q?dpFGD/kdbkiSMhcJSUzfW2wxrCYSuQLg9AfXomhOppkmOlXnwSR9iNUCJBqz?=
 =?us-ascii?Q?kyX2/2tHjYniMLsCxiP/IFDXTMYH6H/3ssQv12PTZq6D58VOeB3P6S7MMaqp?=
 =?us-ascii?Q?Et53Qr0iglWOJqIwLN2oNvyFl//BlLSesg0gIdlWqpQfD9jbya37f97OBfnQ?=
 =?us-ascii?Q?e37AtPJVl5RtYw9gqMQlICLmirGAvqRsjjAIPJiKhs+3N35WEcpTGZKjtk9i?=
 =?us-ascii?Q?raFspzt3V5t+I3aMUnY82OX5nuk7FLWNp4AqFr7lxqGgHZ5o90LEy07Lv345?=
 =?us-ascii?Q?qV1dHzwl1zkYo6yIwAQ7j6ObtdVoP5ikic4FLMbuCyRQz9NUAKwiwL56nOkW?=
 =?us-ascii?Q?Kqse50lcxNMQM4xP9scU0QumBvXhm/mQ5YicoJHHkqGsfzrvKI+InrYaqflu?=
 =?us-ascii?Q?lTXJfAmgjmz+PbthLTn5CLATX9wbmsWVJ6XUeziop/wfJeL3SqOGBndbwcKX?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae91bff2-2a2c-445e-757e-08db812b239e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 09:50:48.3776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdkURKb0JAZZh+vIrn+KcGUNvnZERKJIeaXIS9o+71UDNmnI0p4QBvpgZGrsCGaW3NuoxHC4f6llyrAsVEgl9bqkMrV96ycYdApZ/7vqpRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, June 29, 2023 10:14 AM
>
>Fri, Jun 23, 2023 at 02:38:13PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>
>
>One thing I forgot to point out the last time:
>
>[...]
>
>>+int
>>+dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>>+		  const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	int ret;
>>+
>>+	if (WARN_ON(!ops) ||
>>+	    WARN_ON(!ops->state_on_dpll_get) ||
>>+	    WARN_ON(!ops->direction_get))
>
>Please add check that you don't register to dpll instance which is
>unregistered. Similar check needs to be added to pin_on_pin register.
>
>Also, make sure you don't unregister dpll device/pin which has child
>pins registered under it.
>

Fixed for v10.

Thank you!
Arkadiusz

>
>>+		return -EINVAL;
>>+
>>+	mutex_lock(&dpll_lock);
>>+	if (WARN_ON(!(dpll->module =3D=3D pin->module &&
>>+		      dpll->clock_id =3D=3D pin->clock_id)))
>>+		ret =3D -EINVAL;
>>+	else
>>+		ret =3D __dpll_pin_register(dpll, pin, ops, priv);
>>+	mutex_unlock(&dpll_lock);
>>+
>>+	return ret;
>>+}
>
>[...]
