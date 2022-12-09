Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD46F647DFF
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Dec 2022 07:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLIGuA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 01:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLIGtS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 01:49:18 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351E75080
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 22:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1670568550; x=1702104550;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NLsTWMj+wGlocTQ5JQEVcDX3an9Q2G6Gcdo9R1z0jJ0=;
  b=WZDU4gdgqKvw4Bso01ZWKi8CkpyBTaJSXpyUVXf6bW8fXkBEAQzet+/v
   xxK5dP+VLQfq/YoMsnltoMLyuXRkIJP7Z5RM27sZrmhmOH7adqGES4C2+
   M1FHadCwKLv49MKQ6m2ihTagucP9QjUzXLwEccJOaBsbYJNpe0J97e5es
   vNDrcMJuro02jCoRpT7Mp35fxufmY/O21WPmcudaY/uj1BPw4Ly00Ik+A
   TBKA3KFJyRW6jr2408DhUivGfFgI2k/qLqB2mpzzuOcodNlXKW4SG42hO
   ciyLTPCP3ZWjzIfmnMCoJk8lKQ49Rpq4+Y62uYi+3HMljMOSTUcrN0KiI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="74005270"
X-IronPort-AV: E=Sophos;i="5.96,230,1665414000"; 
   d="scan'208";a="74005270"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 15:49:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOoGqTb1+N5RPZP7y8RH9Frxw/SPylTr1SBYfP9n4bwn2nvPWTmJ1ZEuS2n7GsEa54Ey1y5NXaiRScDLS2w/tCWI6PwM5Wk8lFlUdEwX4sUXvpHnNjq6ufP7I5DJhI+b9pTKZUNO33cTvvg6b9+kkfG8gsRCpVQvpFtamI771cL52yciv0qeUiL9s6XR4p9M2FUx9sk/XpDTvg4AB1PRiRlY7FKPIG8reZrYDZ3/fcToOs054/k55hI/gjBy0OFS3lnypUtvzB7HIkBzAgi3vza0RDwkJY/wSXceqGQCyG2KGz6k6XS/hr4SxvtMMRbmtz02y4yPJ1/F7KEn1UL7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VBTMA7S6l/FIizNpn4LmwASKaDmUtg4eDBTNz9Bm+w=;
 b=EHUDnu0gJphpbLXjsnIbljLZXmmrZXnBmkwm/PBvJ5tbrclYexBnDq4O1nNt3Trtb5/17sq7HYhSUQhgH+cbwJqacjlM0IaJCgZA5qFjxG13FvsPZumGS/zJPIM3LOvwVuC/wl33w890Nhpjmyy+ohIp/w0zOJHAxPMgDRtppFMuQ2xfcXaBMQmbrUFnlSTCtGUtduTL5vsq82ntGgmp3IgIeRQd0i3iNCz9Au4HGHuet3dgGeWiRKLmXiFQtlaJVIm8+T2D/bdZYBRTdnbZfcWTBwGeubuY8oORvbWw55LcVWADSMmAJxowB8p/cVRZGTLOi1fkc9Th5+udOWCqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8451.jpnprd01.prod.outlook.com (2603:1096:604:16e::9)
 by OSZPR01MB8218.jpnprd01.prod.outlook.com (2603:1096:604:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 06:49:04 +0000
Received: from OSZPR01MB8451.jpnprd01.prod.outlook.com
 ([fe80::5b62:2dfb:51b6:ef82]) by OSZPR01MB8451.jpnprd01.prod.outlook.com
 ([fe80::5b62:2dfb:51b6:ef82%3]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 06:49:04 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/rxe: Fix incorrect responder length
 checking
Thread-Topic: [PATCH for-next] RDMA/rxe: Fix incorrect responder length
 checking
Thread-Index: AQHZC0lxlLyHUFXpk0K3A6jvUBWlBK5lDVjg
Date:   Fri, 9 Dec 2022 06:49:03 +0000
Message-ID: <OSZPR01MB84519349CCEAB51FC5A25865E51C9@OSZPR01MB8451.jpnprd01.prod.outlook.com>
References: <20221208210945.28607-1-rpearsonhpe@gmail.com>
In-Reply-To: <20221208210945.28607-1-rpearsonhpe@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 557979ef82704ee6ad1856b2214f9cd2
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-12-09T05:56:20Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=897950b6-d90c-49d9-a9bc-362575e30327;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8451:EE_|OSZPR01MB8218:EE_
x-ms-office365-filtering-correlation-id: d5c6bb7d-a617-4e0b-bbb7-08dad9b1761a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wS18wd2WPmvag3op6mZ84u+gv27b4v18xAlEdAyZh6b6bJapeLc/QFFPiFk9t019ahYUr5VuSLuAgS4rpW3Mwpiy8b5hJuEOsFznyhI5AihuMzb51jMozjNVZSufiFs5OTYPjipKuxN4j1KIEicRihY94uEHZ7RxGGV+oUPgE6C9un1mO5kQT0wrLSynwkKzXtvqpMIxxYsKncjHXooGgXvWcOJKi2l6iSoUGIQaT5usRTY7tzMijwJU0oTzGUUdNKR1emG0rLcq+CbTKnBfmXEVNdkR65oQxs6XwrcZXiM3MQp+VSdSKr4aGeTdXqIVU6iFngqEjXXEWXBGrAr6vbffFtcD8fpwRAEz05Hd44Luhek9E5+QnilFJQ2i85TfzWbvhjAVb80ygo2o7M1T6hdQRWsFpv+vglzfc5oJ9zj8vUaiTr3FWirxnMKtMxJiwEdPQiK7tYUSlQOdWfiI+npzvMJnK0qCYhgCtK+uVbwkOn7qy0y1Th5V25eOV1/PrDbkJ0ytQ7XuxaNR351Xjjjm3bIQ8jE77aPabHhDlGV877oZWyEMNO8sCUtk2zE6aKcY5+VWkBEHMEef2df0Rjb1fSabqwMkcXRbEokVwSgYyOEfvPpVm7M3+wsF5kyfs2ft7ZHZT4nRfSWStx3fDAXb1Q14Xxl+fuzCo+DNW+81LxwUIMDTK6Av2XwyELx7fFFlOeZpsXR8bfR83Lyoc9dBMHPtwX7TBcxkohivwQE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8451.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(1590799012)(122000001)(83380400001)(38100700002)(33656002)(38070700005)(8676002)(76116006)(86362001)(5660300002)(41300700001)(8936002)(2906002)(52536014)(186003)(55016003)(64756008)(26005)(66556008)(9686003)(53546011)(6506007)(7696005)(66476007)(66446008)(110136005)(316002)(66946007)(478600001)(71200400001)(1580799009)(82960400001)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dHNGSldGekhnMDJXQkhRNmlNUnhTeUxqNzh4OC85TDZ6KzA3TTZxeTdE?=
 =?iso-2022-jp?B?eUM0WXBpRzQ4Q3Jub0tRci9WazJNTWd2RDQwclJmSzBWNTBvb2lnN3dp?=
 =?iso-2022-jp?B?WGpvSUpYdWs3WjQ0eGFOOU9qbUdHMUxxYzl5RytkSWNzNmp3LzV6VDlT?=
 =?iso-2022-jp?B?MEdacE9iaHh1U0FkM0RPNlhiSnBuakpFajErcW9aVHB2R2ZMRFhXekYz?=
 =?iso-2022-jp?B?WXVkRlRqSy93S2FmbGFLSHl2Q1VnSVY3MHpVS052V3BBOWlBWlB2allh?=
 =?iso-2022-jp?B?cThQWUo5UUhxa2FWQ3NncmhBSmRVeUk0Rm0vQkJlNE90eVd4M0pYNW5W?=
 =?iso-2022-jp?B?bXNZTWp0MDljVGRvQUFXeFkycnhnTkd0Ymt0N043RzlONmdHazBsRkxS?=
 =?iso-2022-jp?B?djRLQk1Bbk93UXdoSWY4b1J3WWFsWWtwZm1WUzVlMVFCc1AzdjUwWlhZ?=
 =?iso-2022-jp?B?VC9KWWhTTG0wTERwMmF5dHJod2x1SWhvQUdmTCtSTk9UNFkya1pvSmFG?=
 =?iso-2022-jp?B?ZXk1NXlvMGdMeTZ5Z2xyRVF3NEFydjZBNGs2aUdpcytBcndBZHQyNVVQ?=
 =?iso-2022-jp?B?SmNtdlQxZVpOUHRvUHNrbEpwN3R6RVJlZjh0Q0NLemppZnRSZlBiYUl5?=
 =?iso-2022-jp?B?SU82RjJwM3Y5WG1sRzM3VitMd1FoMmlkMXMxNWk2a01BOWZLV1MzWVhl?=
 =?iso-2022-jp?B?bFd4NWxCV1o2SVplYnN0bHphMXhWcEtwSXFkcEt2RkpHcnZUeTVmOFhi?=
 =?iso-2022-jp?B?QmNRcC9LbDVzUEdpU2dsTFR5dlpZUnJCMGsrUm1zM3o4V2RoOEl2OEJu?=
 =?iso-2022-jp?B?OVZnVHpFU1paMndJU2hrNG82cERRWFFSYTZWdGpkSG9QNHduY3l2c21M?=
 =?iso-2022-jp?B?WUIzdUdWWDZPL1BjOENjbkVvM0NtVFZxc1BpbUI1WUNXRzZMU0RBRkV6?=
 =?iso-2022-jp?B?Rm4yOFdtWWF5Sm1kbS9jd1pXSjdxRW1tenBzODJvNjRQWEhwVEQvOGx5?=
 =?iso-2022-jp?B?d1I3NjRkaTNzWGI3VFVQbnRCenpBekhtTDZtNERpVG0yMitneVZCaFp6?=
 =?iso-2022-jp?B?cm4vcENHOGI5MXlXS3JXdHJpc1NGZ1U5QW83TFdmZVU0bGlYZzRpQzZY?=
 =?iso-2022-jp?B?Uzc2bnlpU3JIWEFVYldMSk9VNC9JUGpEVFhyYkh5eDI5eXJ2ZitMajlz?=
 =?iso-2022-jp?B?Y3lCYWtmc0N6VXJSYnVwcXB4SzRuZ3RrVWhFMTI4NTJsekxNY29naVdS?=
 =?iso-2022-jp?B?Y0kvRmkxQlVTVWs4aDhMcHBVRTIydHg4aUVDVzI5d2RNeDVxMEhRSDR4?=
 =?iso-2022-jp?B?QTdXbHppNWkyT1UxY0pjaVpmZXA4R3MrU2VjZ2h6VDA0MDNueGtNQUIv?=
 =?iso-2022-jp?B?RTkrbXVFZjZzc3ZOUmhjTzBoOU4wd0FVMzZ0L3ZxNllzNDVBWWNlRENz?=
 =?iso-2022-jp?B?aVlNblZkYTZvcUY0WlVhTndOa2tRR2Z2S3NlWHpiczZjcklzMWVwTzhL?=
 =?iso-2022-jp?B?Y2szNFZGSGFWYkljME9SRkVTQmdmMU1WVkxMVUVhYkVaWkJLbWRIR3J6?=
 =?iso-2022-jp?B?Y1BhL2F3THdHbDhUVmtDTW53d05JcXZtRE1TNkhoUEw2ZjFlMHY2R01X?=
 =?iso-2022-jp?B?Z0svZEp1eWx3MGxjdEI2TFlxWDloQVdiOEJjdlFycTVVZ04zeFVLMmM3?=
 =?iso-2022-jp?B?Nmd0dHNtTWlvckdsaDZtMjBaQnB1a2JYOHluUi9XeU15UGpJSWJUd1lB?=
 =?iso-2022-jp?B?ektvV1JPTUdBMFpmUlNHV2c5NTlsVFNnUGxOcThYb21zaFhqM1UyOVFS?=
 =?iso-2022-jp?B?OW1xVU8xZ09kd0J5b0lIQ3N3Rnp5Ylp0TCt5UW91ZElLVkF6MEVRdTQ3?=
 =?iso-2022-jp?B?OTFDeWFpbEtZTWVKaVVoZFVlcXVGdTNVRURoNy9xaWlVSjc4V01LT2d1?=
 =?iso-2022-jp?B?bjA3U2FTTlJhYnk3cGFmQmxUNG1QOStocy9iNU9lOHdFaGVlRzBoallU?=
 =?iso-2022-jp?B?SzRzQXFHTHRGUVpFR29wY3ArdTBrbndoZVBaNW1uditGV3FNQWxuKzdD?=
 =?iso-2022-jp?B?ZktxSjZhOUNzbFhwWWE1RWdOL1RoWG5WY2tJVmJnNWNsYW1qcitJcHFC?=
 =?iso-2022-jp?B?VTNEYVJrSG5PYWpiOFBGaWlJWUd4aG03UUN5Rk9iczBqcEJOcHVPWGhL?=
 =?iso-2022-jp?B?dzBBQWg1Ykxtc24yMDBKVnJYYU9GU0tFUGVzdURuYksxbEFMWnp6UlFG?=
 =?iso-2022-jp?B?WldiVlRyenFhS1BqRTlkZFVLRjZZK3Q5OG5zUGJucGEweUlpYmNqS3FM?=
 =?iso-2022-jp?B?bEpFS3hxa21jUjBIOXJrKzNGaG9MandVZWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8451.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c6bb7d-a617-4e0b-bbb7-08dad9b1761a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 06:49:03.9780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoMQKnj1u1w8slOpfHhqRhyQUfTOtWJZJIhFe77MeXoYcWDvQABP2AWlfM1IM7aBLyitbZ/g6kThjXmvBDqVatGa7CugePo2yj3doBXu16s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8218
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 9, 2022 6:10 AM Bob Pearson wrote:
> The code in rxe_resp.c at check_length() is incorrect as it
> compares pkt->opcode an 8 bit value against various mask bits
> which are all higher than 256 so nothing is ever reported.
>=20
> This patch rewrites this to compare against pkt->mask which is
> correct. However this now exposes another error. For UD send
> packets the value of the pmtu cannot be determined from qp->mtu.
> All that is required here is to later check if the payload fits
> into the posted receive buffer in that case.
>=20
> Fixes: 837a55847ead ("RDMA/rxe: Implement packet length validation on res=
ponder")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Looks good. Thank you for the fix.

Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>



> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 62 ++++++++++++++++------------
>  1 file changed, 36 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw=
/rxe/rxe_resp.c
> index 6ac544477f3f..42261537772c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -392,36 +392,46 @@ static enum resp_states check_resource(struct rxe_q=
p *qp,
>  	return RESPST_CHK_LENGTH;
>  }
>=20
> -static enum resp_states check_length(struct rxe_qp *qp,
> -				     struct rxe_pkt_info *pkt)
> +static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
> +					      struct rxe_pkt_info *pkt)
>  {
> -	int mtu =3D qp->mtu;
> -	u32 payload =3D payload_size(pkt);
> -	u32 dmalen =3D reth_len(pkt);
> -
> -	/* RoCEv2 packets do not have LRH.
> -	 * Let's skip checking it.
> +	/*
> +	 * See IBA C9-92
> +	 * For UD QPs we only check if the packet will fit in the
> +	 * receive buffer later. For rmda operations additional
> +	 * length checks are performed in check_rkey.
>  	 */
> -
> -	if ((pkt->opcode & RXE_START_MASK) &&
> -	    (pkt->opcode & RXE_END_MASK)) {
> -		/* "only" packets */
> -		if (payload > mtu)
> -			return RESPST_ERR_LENGTH;
> -	} else if ((pkt->opcode & RXE_START_MASK) ||
> -		   (pkt->opcode & RXE_MIDDLE_MASK)) {
> -		/* "first" or "middle" packets */
> -		if (payload !=3D mtu)
> -			return RESPST_ERR_LENGTH;
> -	} else if (pkt->opcode & RXE_END_MASK) {
> -		/* "last" packets */
> -		if ((payload =3D=3D 0) || (payload > mtu))
> -			return RESPST_ERR_LENGTH;
> +	if (pkt->mask & RXE_PAYLOAD_MASK && ((qp_type(qp) =3D=3D IB_QPT_RC) ||
> +					     (qp_type(qp) =3D=3D IB_QPT_UC))) {
> +		unsigned int mtu =3D qp->mtu;
> +		unsigned int payload =3D payload_size(pkt);
> +
> +		if ((pkt->mask & RXE_START_MASK) &&
> +		    (pkt->mask & RXE_END_MASK)) {
> +			if (unlikely(payload > mtu)) {
> +				rxe_dbg_qp(qp, "only packet too long");
> +				return RESPST_ERR_LENGTH;
> +			}
> +		} else if ((pkt->mask & RXE_START_MASK) ||
> +			   (pkt->mask & RXE_MIDDLE_MASK)) {
> +			if (unlikely(payload !=3D mtu)) {
> +				rxe_dbg_qp(qp, "first or middle packet not mtu");
> +				return RESPST_ERR_LENGTH;
> +			}
> +		} else if (pkt->mask & RXE_END_MASK) {
> +			if (unlikely((payload =3D=3D 0) || (payload > mtu))) {
> +				rxe_dbg_qp(qp, "last packet zero or too long");
> +				return RESPST_ERR_LENGTH;
> +			}
> +		}
>  	}
>=20
> -	if (pkt->opcode & (RXE_WRITE_MASK | RXE_READ_MASK)) {
> -		if (dmalen > (1 << 31))
> +	/* See IBA C9-94 */
> +	if (pkt->mask & RXE_RETH_MASK) {
> +		if (reth_len(pkt) > (1U << 31)) {
> +			rxe_dbg_qp(qp, "dma length too long");
>  			return RESPST_ERR_LENGTH;
> +		}
>  	}
>=20
>  	return RESPST_CHK_RKEY;
> @@ -1397,7 +1407,7 @@ int rxe_responder(void *arg)
>  			state =3D check_resource(qp, pkt);
>  			break;
>  		case RESPST_CHK_LENGTH:
> -			state =3D check_length(qp, pkt);
> +			state =3D rxe_resp_check_length(qp, pkt);
>  			break;
>  		case RESPST_CHK_RKEY:
>  			state =3D check_rkey(qp, pkt);
> --
> 2.37.2

