Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F2616456
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 15:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiKBODI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Nov 2022 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKBOCz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Nov 2022 10:02:55 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F10E0EB;
        Wed,  2 Nov 2022 07:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htxn6/gS5E54j+Q+NfIWC+Ui91qVCU+mSUrE+mTzGQzTD1aRKMU4/zXraMRl3ZqBn3F4jyh23eyfCL0h/Khob2tXGqYDoh/AWMbpV+D8CyNo2gp//DZfhJu9vKghDrvc/rNCtfpS4YXEMq4f7DG+0N7rH/2Zk0X6gEP67TobFSLF1rVc8ETgeB67yynomQx9tpCWcePTdz/GahhXiLPLSt7kMnsNlsMcxfI0Skw9/cCgrWXci5Lk+VxBWg5QCmEgIxpIWQ55vjeTf1S/FcOnZCr9OJ1/WKBUqcf1PJocFRQwbUv0XJr6fuV5rAnAuFXJvP2mnt5vARon/TuUu9ewUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ8Jn7LGD0MnFLdNyuPQ2y5eIXQM/CwAlk4uca6RySw=;
 b=aFdViSTjKpjlLuBG0Dyoyww/OKFKBtvBoGhiarW5aIGclnzy49yPNwEitM6F6hBNp8LFfLRNEw4my32wFNqP1/+EVOlIk4PsnphPHlWo4AcPI4UKNLDOA+D7TF6uo77h8dyE5YXXmoNIMEP4kUucCU23wnbGqRHevxwgtgWlCFkrBAFCv4lJYgRl8nxyDTUpMTWM/4ixV6XX0twoqvLDE5cIt9RCd+NR6b/8WqmaLkgiEEB9iQopA/BM2twEPvc18xtT6nZWBfj0IOvTm+x2gMPcKaafdXVMGAiozWPFFl9za8jUcKbAJWJ8wJxP/QTyymSQ2ag5nFT/L0jWR75+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toganetworks.com; dmarc=pass action=none
 header.from=toganetworks.com; dkim=pass header.d=toganetworks.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=TogaNetworksLtd.onmicrosoft.com;
 s=selector2-TogaNetworksLtd-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ8Jn7LGD0MnFLdNyuPQ2y5eIXQM/CwAlk4uca6RySw=;
 b=fnOilON1hVkNDNAEHEWoZQJozFjqlDB0p8UHMF6IIRcQ2TNP0deEHdYI7WxxkDbRs9spid8TlGBLjtMirtAljLenjy9f+Zu1hd+yFH0e1eJSIYatFCiILzblA++FuFxdIkdQH09N+k69n7emehHWKKq6rlqMninas/nfZPSTuPA=
Received: from VI1PR02MB6237.eurprd02.prod.outlook.com (2603:10a6:800:17e::7)
 by GV2PR02MB9544.eurprd02.prod.outlook.com (2603:10a6:150:da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Wed, 2 Nov
 2022 14:02:49 +0000
Received: from VI1PR02MB6237.eurprd02.prod.outlook.com
 ([fe80::b8a7:7177:555f:150b]) by VI1PR02MB6237.eurprd02.prod.outlook.com
 ([fe80::b8a7:7177:555f:150b%4]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 14:02:49 +0000
From:   Leonid Ravich <leonid.ravich@toganetworks.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yigal Korman <yigal.korman@toganetworks.com>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Leon Ravich <lravich@gmail.com>
Subject: Re: BUG:  ib_mad ftrace event unsupported migration
Thread-Topic: BUG:  ib_mad ftrace event unsupported migration
Thread-Index: AQHY7qUIEmC+0HXRl0GAS6BMUX6rtq4rg8WAgAAVo4CAAAytAw==
Date:   Wed, 2 Nov 2022 14:02:49 +0000
Message-ID: <VI1PR02MB623731066685B6E249F71A3189399@VI1PR02MB6237.eurprd02.prod.outlook.com>
References: <VI1PR02MB623706DA8A01842834FC191089399@VI1PR02MB6237.eurprd02.prod.outlook.com>
 <20221102074457.08f538a8@rorschach.local.home> <Y2JqX3vC1mG/JDex@ziepe.ca>
In-Reply-To: <Y2JqX3vC1mG/JDex@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toganetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB6237:EE_|GV2PR02MB9544:EE_
x-ms-office365-filtering-correlation-id: c49d30e0-e698-45cb-7a7a-08dabcdaed24
x-ld-processed: 73f7e7df-ca98-4f08-bf85-f137b447da96,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yrP3m7cQLywbx8FLS1eWuDsMoinzH3c1aSMYRDQcvWNESTN0d+yn6wzLfVNHU90DOErsTS4CfikSO8DvmFsiHh2ZRwMFt+RXCfLuz70wbKuO/h/uu6ZqdkUBU6CxY8qUILFbpKT5NvQBSm3vcITSKHve53A70h56s9dOiShe+DBRWdnCJ5itwJlvwFXV9idEdCL43hB68GcCB1hlGrUmWITUl4v1YMR/9XXYcokU1I/ai4Zes40vUUS8+05mNUW+TE8R2j2cnIh8cyN6XiyGDnOA/LYgd8Slx2Rezd9IzWnRLe6XP/1UuAAN72yRxTlQ61+nRD5VusSdE3vWp/zBLmNPy5aJVfzmZZNt9CkYo1Wg6SBK8qYzHPs5U/JZ2vanlHd6YweVkX8zVhP8v963DrOoPfsxDgfXo77HQPufv4Yh5SJPfa4dA8c66JO59AK+X47puUT+qB9EXJKZ9Ke0FPitmuWGOCL5bV6A29C//guCjSOiw/fnjBlcPxw9Hw5lpjAQRYTAbQjNbR8cEqJ713cXuxnO5EJX0kIBd9DmfdCh/DvHgkmaUVUQqkl6fOjg9ME22v5tIhKwWRFRyDhPtKE/V+y4CZGHjSSU6+PMYCB7sBehK2yD8LG1DBYFTUkXansOOGTQFeUi2+xbItj4kXqeIGemUwigwku8UhFHEW9/zM6gviCtJrUUvWe6uZZ/KbPiI61zd4qAYPL/DdELkpdIpLlBNQn001ErF9Xl3ruQVpgvuFbsKQWj1PnLxqJebdqdNC2kTlTCzLQrnm8PCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB6237.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(39850400004)(136003)(451199015)(66446008)(76116006)(91956017)(4326008)(66556008)(66476007)(64756008)(66946007)(8676002)(186003)(44832011)(86362001)(478600001)(33656002)(5660300002)(71200400001)(2906002)(52536014)(41300700001)(110136005)(8936002)(54906003)(316002)(7696005)(26005)(9686003)(55016003)(38070700005)(122000001)(38100700002)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/FbVyWFVbUcqIjeZjHfsgpq8ON5E1MfuelKtjhS5QTxNdrYOeM1f16jsbv?=
 =?iso-8859-1?Q?cOghM7+7ACIkIeytp9nU8bVAE1XbgnVg4O2ZOmucjSkRzG56Cu96BEa5KX?=
 =?iso-8859-1?Q?XZbLJiR99TBEc5/+da9BcT/PoGAd+jwjzhhqrgpbujuZxUEiDwvL2yurmS?=
 =?iso-8859-1?Q?wBdaBCP+BUhu5qKyfrrQpsCeQs4PCXtXCWCNpsUxbdcH5NPT3+G7JJfqnS?=
 =?iso-8859-1?Q?sR5JV0o08K0MEXCYaMDPZ8M6f9pKlmL6xP7Ehhinyo5s5kXl7xoj+LAeIf?=
 =?iso-8859-1?Q?lDYlpktYL9pC9UzYHNUfsUkJoM0EbBvwPeqCF9NXtmMqt33v0/fl7/i0wG?=
 =?iso-8859-1?Q?G0E9kjneLl+o0ZMPwuwm9uNhROnzhE7WUk7sj3OhRHq12gEQHBCDWpR2wg?=
 =?iso-8859-1?Q?oI229glTMqdFxosRC3dLyFU8wpoARbmPuZtOmmRCQ0Nts4v5ZdxpQ1IGnf?=
 =?iso-8859-1?Q?fyeTOvehcL7WuzKtvDQ3czyDKV/PbPKzs3lmvV4gG+8pt4yNi+O6LSoCZM?=
 =?iso-8859-1?Q?eGmf7wOOfholIbg6hcaMLroSlrhCt8MC21Q41oI7LUzXEv+60HAPiyGnUE?=
 =?iso-8859-1?Q?84LX++wBRYL1f9rJA2arK+lIYjCqJoelasnyoHBNMccHqTo1MZDa756lVE?=
 =?iso-8859-1?Q?8DGwmS5nhzfy8NkUQA/SURHg67NtcKAa68ROKHgZ7Di2D50qWmI35d+7HJ?=
 =?iso-8859-1?Q?o3DCZ5SMNgj95JJKTwH+A4N/NnanMloseyB5u/RY6e40M5M3luHltDcsBf?=
 =?iso-8859-1?Q?Vl7jGGPyUkAN30s6ws+b15UFg/btXnI1mr8J95EXqVPTZmGdybdOC9Gmoo?=
 =?iso-8859-1?Q?4Vjye1fyJfdfr3MHAnixvH5EJ2VOTsIo31nG6PrCuC7kUPlQK3ozsjVBuY?=
 =?iso-8859-1?Q?EBsBRJt0377490IBMEOxgkoXYYNkITQqVTvbKbuOPtVUeWc5xcMNz+QZbo?=
 =?iso-8859-1?Q?aYFXlsbK2X/9aK2VqAHKCbnMNFkrrCxy4sbLnn0gSRrxbTo2U57mzcl9U3?=
 =?iso-8859-1?Q?jjdYxJbArXBB/rlqpZVYRlq+/m8kCFwqaLIu9Y20k2lzz1lOHSeFmTe8Xa?=
 =?iso-8859-1?Q?Pi/RgVteVOaUVGF/5yvDOMDiMMy1DFkx0inKNUx2l6UYKFbrG3DlgLPv8X?=
 =?iso-8859-1?Q?Db31l6q/8ZuG3wQcf58TngsqWZNg+OB0j0dLRL6HJUDIMikL1vE/dAHLWE?=
 =?iso-8859-1?Q?Yl+e50StuRSK9CuYnuaxwdodDN1S1SGyOxam7KeMc/pAFekufbDx5I89rh?=
 =?iso-8859-1?Q?6eIoRCw0xQ85avgqMIxgUZErZu27duL8reGLWzkasfTaLdxfTPCo+JZovI?=
 =?iso-8859-1?Q?Kr58IWVQSzu5C5fFW3z1RWlcDqCpPHc49fEexmxOfJWa5x+76n7r98U3tT?=
 =?iso-8859-1?Q?BRQQCQFiT20Bq/koJCT8klPr3n+rtD5pzNcxaMCBZv54bSPlUFJXP427f0?=
 =?iso-8859-1?Q?/P7/fojEzcKlS5TH94hU6R8shj9Z3XDSavNW92AIA3JGLBeKjfZXUUqv79?=
 =?iso-8859-1?Q?ZrzDHETKGqWiqmIMcjq+9QfTtwKnSym26ei00YFexypjrdTWgd37j0ejfI?=
 =?iso-8859-1?Q?z1z+U/e5QOqJIDCSUV4a+q4IFLcBiDltXB/PVVcFj91hgqpdXNJ6gWInvT?=
 =?iso-8859-1?Q?d9NgjZkqBqVA2EuHGaHbxeVnDxN6VDmcOFvopNEbj0Vwc8SJKnNnj+WA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toganetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB6237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49d30e0-e698-45cb-7a7a-08dabcdaed24
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 14:02:49.3204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 73f7e7df-ca98-4f08-bf85-f137b447da96
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joG7KbWwt279FTX/gD5h3ooiakDveDkYf2UWGlaCZhYRotGmusxR4T1+GlzJM7Ch/m1VcCQtyKIIR1z50H6jZJVo22h7nOfhZV+WUi7O63w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9544
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > > before starting throwing some patch into the the air=A0 I would like =
to align with you the approach we should take here. =0A=
> > > =0A=
> > > my suggestion here : =0A=
> > >- ftrace infra should verify no migration happen=A0 (end and start hap=
pens on same CPU)=A0 in case not we will=A0 throw warning for the issue=A0 =
.=0A=
> >=0A=
> >The scheduler should have. On entering the ring buffer code=0A=
> >ring_buffer_lock_reserver() it disables preemption and does not=0A=
> >re-enable it until ring_buffer_unlock_commit().=0A=
> >=0A=
> >The only way to migrate is if you re-enable preemption. WHICH IS A=0A=
> >BUG!=0A=
=0A=
>So what on earth did that?=0A=
=0A=
>I'm guessing some driver's query_pkey op, but AFAIK we don't have any=0A=
>explicit pre-emption reenablements in the code - unless it is sneaky..=0A=
trace infra uses preempt_disable_notrace/preempt_enable_notrace  to disable=
/enable preemtion but  my kernel compiled without CONFIG_PREEMPTION so this=
 functions are only barriers - looks like the idea behind was to avoid invo=
luntary preemtion  but in our case it is a voluntary (there is a wait_for_c=
ompletion in the query_pkey  rabbit hole).=0A=
=0A=
so no scheduler here to warn about illegal migration. =0A=
=0A=
>Leonid what driver are you testing?=0A=
mlx5 - (MLNX_OFED-5.3-1.0.0.1)=0A=
