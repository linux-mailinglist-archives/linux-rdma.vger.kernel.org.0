Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5A0217F06
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 07:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgGHFR7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 01:17:59 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:21472
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbgGHFR6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 01:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vabQqrAuQYwYNDGDFtG2VuEifIaSq/9MbS5JR9OF5vk=;
 b=GW0FSnMyvnPePrJdmwjpdsgz2V1tWlWdSdL43fxqzDX/hI2mySmXHSEoeDAltLTdjVN53AGT0LXW3pNFxWstoCxYlWzarAgHONBSVRps8TdV/G9A5ApqIaIIFuZWVCVGzLSct2huksusPzX0xnDdKagJ9ywnt9TgRSuJgCyU9B0=
Received: from AM5PR0301CA0036.eurprd03.prod.outlook.com
 (2603:10a6:206:14::49) by HE1PR08MB2889.eurprd08.prod.outlook.com
 (2603:10a6:7:39::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Wed, 8 Jul
 2020 05:17:53 +0000
Received: from AM5EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:14:cafe::92) by AM5PR0301CA0036.outlook.office365.com
 (2603:10a6:206:14::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24 via Frontend
 Transport; Wed, 8 Jul 2020 05:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT042.mail.protection.outlook.com (10.152.17.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Wed, 8 Jul 2020 05:17:52 +0000
Received: ("Tessian outbound b8ad5ab47c8c:v62"); Wed, 08 Jul 2020 05:17:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: dd83d31ab9145d15
X-CR-MTA-TID: 64aa7808
Received: from d80c61bc7052.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 43B1A02E-0221-4D9D-978E-30893710AF51.1;
        Wed, 08 Jul 2020 05:17:47 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d80c61bc7052.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Jul 2020 05:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfqazUfyc2QDHKQrXvRfuAol8gtfSOWxBMtASPdmYzzPHq4XIf3ZTY35F35F/Y6ImuYsNAZop67LVqo0BhDStjVvWwzpbg0GLorTdyX1w5hBGTrlCO5GgG+U3nIRePgjEuwB3+sRX6J9ejOB/nQHcE4Qk/Cnw4a99sVqCXn6kp+xjynh37utk5kZ03DrgcRMUCV1HOOiYtm7BSovzSnBoByZTCRwTunwKrtpRsd3jW6f9AcXhHHIrNjK/qP6iUfEhFaQPVeq92QD0ibDVhrJOFVL+sbIrqeuQ4e43jyb0lEdOof4FL/v4tAIvbea7WdTHmlHjfxj78lXNYQ5MSsPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vabQqrAuQYwYNDGDFtG2VuEifIaSq/9MbS5JR9OF5vk=;
 b=b0J1MqrD0Y/4oTdYmXqPk2l/iANsCFUNCwZYbjBtZEaoQTBlpcXXhwN2XrBjJbyBhJxnwBdXvLmhLFEKuR8z4FuI3xT5xjASV/+vuzeY0dkgqj3ikLkbhTT9C36EIDaMGNvq5Cc4toDhFaDlilBMUWNOcNvi/r5XkJDntdtPPkY5QwkzABn5ZvIRUzxl7Jcdb9lTsaQjpkgMSpfflPduAZr6oq0fLPjviAoZ85uS/q22x5nunGAoc3fliZzIB2JkfC6SV43dH2gRxkys9x5FvFREBC/WXF+EaeXtttNy3MH6J4H4P1PBBHI+4R9cCRblIriXSEalNDWm0daoRaLEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vabQqrAuQYwYNDGDFtG2VuEifIaSq/9MbS5JR9OF5vk=;
 b=GW0FSnMyvnPePrJdmwjpdsgz2V1tWlWdSdL43fxqzDX/hI2mySmXHSEoeDAltLTdjVN53AGT0LXW3pNFxWstoCxYlWzarAgHONBSVRps8TdV/G9A5ApqIaIIFuZWVCVGzLSct2huksusPzX0xnDdKagJ9ywnt9TgRSuJgCyU9B0=
Authentication-Results-Original: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=arm.com;
Received: from DB6PR0801MB1719.eurprd08.prod.outlook.com (2603:10a6:4:3a::18)
 by DB7PR08MB3868.eurprd08.prod.outlook.com (2603:10a6:10:32::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Wed, 8 Jul
 2020 05:17:45 +0000
Received: from DB6PR0801MB1719.eurprd08.prod.outlook.com
 ([fe80::7d48:27e3:a154:17ef]) by DB6PR0801MB1719.eurprd08.prod.outlook.com
 ([fe80::7d48:27e3:a154:17ef%12]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 05:17:45 +0000
Date:   Wed, 8 Jul 2020 13:17:39 +0800
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Daniel Vetter <daniel.vetter@intel.com>, nd@arm.com
Subject: Re: [PATCH 07/25] drm/komdea: Annotate dma-fence critical section in
 commit path
Message-ID: <20200708051739.GB1121718@jamwan02-TSP300>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-8-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707201229.472834-8-daniel.vetter@ffwll.ch>
X-ClientProxiedBy: SG2PR06CA0168.apcprd06.prod.outlook.com
 (2603:1096:1:1e::22) To DB6PR0801MB1719.eurprd08.prod.outlook.com
 (2603:10a6:4:3a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (203.126.0.111) by SG2PR06CA0168.apcprd06.prod.outlook.com (2603:1096:1:1e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 05:17:44 +0000
X-Originating-IP: [203.126.0.111]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9267f351-2f87-4ef1-85a7-08d822fe43df
X-MS-TrafficTypeDiagnostic: DB7PR08MB3868:|HE1PR08MB2889:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB2889CF6A93C66293D6756C28B3670@HE1PR08MB2889.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;OLM:2657;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: jDiJGX2baiX78L9pswf7A9ywXULHVdvit3myihlymPL7dTK5JuS31t5ZL1WR9uY66ABsW+gVxmN87WqlJDUM1GtV2gzcMDb7Y0HYbtcg6DYNlCoMW6fsWRBaDlnEWaNqUY5DlodwxMYXA6p3Xn7l9By9gcDfsD3G+woPxagxKbqhAk81/3bB2Mtfwrr2k/Idkp0sWCAvxT6wS653JeK5Z46sqEKRM+UiiYdgdeqfg2HH22oUJtRCxmOCwXtjYM/qu8r4mI/s0b2i95Ea7FPtKXLykh6miYaaf0nAg8BqYrACUAZ7EWEr+YExQ93DNYaW6GXwSU6FBtFNaFfWJDLK8A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0801MB1719.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(396003)(136003)(39850400004)(376002)(346002)(366004)(2906002)(54906003)(5660300002)(6486002)(316002)(8676002)(33656002)(4326008)(956004)(66556008)(66476007)(66946007)(6496006)(1076003)(26005)(16526019)(6666004)(478600001)(186003)(8936002)(52116002)(86362001)(33716001)(9686003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 34h5QetlT6bw4vv3Ydu4HHyQNQ49F0XZ+lwBGSzEKAUtXWN5Jrx/wfyK4QhAK209xqY2vrZGDeKHQBpciX9Ih07ugjdPiaiMvlUv3EnCnNYvTrc0yI7wJgeuB/WfP4eMAocf+JTppa728rNJBDSI5YcxPR72KpP6cqenwLo41LmYXjUheuv+EQ73r60ahmZ2i70gxt0tSAetu+++nKpKfYVv8P4uOvW4lrTT1G6sEfBhg8zzm25d21pT44Vf0mlqZj0yr0SZhtsKrpH+2jx0SYROSR41jCluo8rXPsCAuvA4WFXiTGrRf4xeanw6Ada5DIX/rSoJ3HT+i8sYk04Ef7KPjQWZ6MpsL1WnN+BQpogiHYPPgIyM1kkvIOwXB0UW3+p9I+5SOtA72W07wMGZW4sQ+J+y+SHZ0sPPWtRxWlRK5AJ/UyYePSaycDEEt3S4s1B7WgOFXM0c9uuhjUknIpPKVhKtZjg6tp3VBSCMrpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3868
Original-Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39850400004)(376002)(346002)(136003)(396003)(46966005)(1076003)(8936002)(70206006)(70586007)(9686003)(6666004)(4326008)(956004)(2906002)(81166007)(86362001)(6862004)(336012)(33716001)(16526019)(186003)(6486002)(33656002)(82740400003)(47076004)(5660300002)(54906003)(6496006)(26005)(82310400002)(316002)(478600001)(356005)(8676002)(36906005);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 84b87371-f21f-4e29-86ac-08d822fe3f6a
X-Forefront-PRVS: 04583CED1A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grrDH0Dj8Vwg8lZHXEteqZZego0gxRHourB5nREx5y8GzJGREJWxjTyE7N5ur/r4/FCqTLdm+ttwoWrcbeDT5OaCra/3LhgYzobWHL1GHwurojepG/o8BDryTZcCyNYPs88E7+LkBgTy2F/7US/j7rPgJyloWy9GR6dnFBCcebA+QETX02tTUSSu16Ct31zuKG3YQknTzojgV3LQdoRHg7JiNqpG39vyxrfHvra3YltSzV51zM/YStZB3Yd6cILKuYFgcOumdfUk/A7maCBfDJgGjy4f3SfkYNkv0nd6jPjm2a5cn2fQemyNCmzHgMUUpUgkxJEHq4jHJ6qSnCwZ5TlisI/mM4yLO9xdZUNeE/GzZExMvCA6W9bnhz+aBMl0OsdRzUfmNJT2SXjBx7B8KA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 05:17:52.7975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9267f351-2f87-4ef1-85a7-08d822fe43df
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2889
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 10:12:11PM +0200, Daniel Vetter wrote:
> Like the helpers, nothing special. Well except not, because we the
> critical section extends until after hw_done(), since that's the last
> thing which could hold up a subsequent atomic commit. That means the
> wait_for_flip_done is included, but that's not a problem, we're
> allowed to call dma_fence_wait() from signalling critical sections.
> Even on our own fence (which this does), it's just a bit confusing.
> But in a way those last 2 function calls are already part of the fence
> signalling critical section for the next atomic commit.
> 
> Reading this I'm wondering why komeda waits for flip_done() before
> calling hw_done(), which is a bit backwards (but hey hw can be
> special). Might be good to throw a comment in there that explains why,
> because the original commit that added this just doesn't.

Hi Daniel:

It's a typo, thank you for pointing this out, and I'll give a fix after
this series have been merged.

for this patch

Reviewed-by: James Qian Wang <james.qian.wang@arm.com>

> Cc: "James (Qian) Wang" <james.qian.wang@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Mihail Atanassov <mihail.atanassov@arm.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 1f6682032ca4..cc5b5915bc5e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -73,6 +73,7 @@ static struct drm_driver komeda_kms_driver = {
>  static void komeda_kms_commit_tail(struct drm_atomic_state *old_state)
>  {
>  	struct drm_device *dev = old_state->dev;
> +	bool fence_cookie = dma_fence_begin_signalling();
>  
>  	drm_atomic_helper_commit_modeset_disables(dev, old_state);
>  
> @@ -85,6 +86,8 @@ static void komeda_kms_commit_tail(struct drm_atomic_state *old_state)
>  
>  	drm_atomic_helper_commit_hw_done(old_state);
>  
> +	dma_fence_end_signalling(fence_cookie);
> +
>  	drm_atomic_helper_cleanup_planes(dev, old_state);
>  }
>  
> -- 
> 2.27.0
