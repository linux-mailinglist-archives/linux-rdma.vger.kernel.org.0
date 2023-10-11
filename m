Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F47C60E6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 01:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjJKXMG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 19:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjJKXMF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 19:12:05 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B82CA9
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 16:12:04 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66cef33a4bdso1989356d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697065922; x=1697670722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rULuvUvnuG1CX4LiHBwNEfcd4JOf3InADvu8MYgVkDI=;
        b=hTG8WIap3Y1EbGflt8R93QtrWRgm5NjPBXf/w6xeQiZwiQbRYuZcUWldHSvpzVpH31
         Gdm/aLmJ+pax48cM2GVYfjabxBkCv60zLKBs8sBLV0IWHC4C+kLD/xAqjBBVe5tPJNn4
         372bccJjqY+PQyQu7xLN81dTzO3iZ7vtWhECUKHHHg4BWoEjyfN/Nr5kepfhjpZPGbhi
         tGOgTWbWyoMt8gJSPsRxhwAUSf8G/Wdvfr7QKWvweVb0PBlguAOOk4bLPVDON/UclG3X
         G22zjiw9GQRJmN3/I0GgXd7dGXoQCX7frkg8zUOrlmtxcAy6KaZdmFz3kD2XX0b4VhrQ
         YY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697065922; x=1697670722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rULuvUvnuG1CX4LiHBwNEfcd4JOf3InADvu8MYgVkDI=;
        b=QgrxOzdsjvyf1UTOeFPR0Z6PsgO+yCwp/ZvAHgjGS330Zsuy+QpMRBdYoeJhiToJKx
         /OAYpxCUzeXwsuFIRBnudbCoUOTYb2nk2YOW3qawX5ZWAxLhYp5mfz1i2G3uqHTlfM5n
         cjZtwrlM5keEFbioZHEbE78uwxclobtPtpgeOwf+L6MNCkHIX5T23v5rRbZ77kQcJAoO
         0QZqlQJT4lJAMFofOvLWr986y8ySrbyXvo/FLwGQzTt03/W21/ZV6vLdYeBL4T/UgOX/
         o6Zj63ZvErTG9cBbtkdDTQ3T3WwokbbRH7MuoFOIcTf1B0cYkLMyv3Nbj6623JhrZRcO
         44gg==
X-Gm-Message-State: AOJu0YzKegiMsHnMCCCFxdMjWuVqmcJZSOcuYrnO82YkLzmU2vnCHY8H
        C8PfWgAyxLNy+tJBbWMDV/K43w==
X-Google-Smtp-Source: AGHT+IHAdoL/C7864vxcmWQAWizjkMnu8Ywa5Zls/FUMDs/09hVwrQ/aN28WOiFXPUtPodjMkjH5eA==
X-Received: by 2002:a0c:dc14:0:b0:66d:566:9174 with SMTP id s20-20020a0cdc14000000b0066d05669174mr3074371qvk.32.1697065922510;
        Wed, 11 Oct 2023 16:12:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id w9-20020a0cb549000000b0065b14fcfca6sm6095577qvd.118.2023.10.11.16.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:12:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qqiMz-0014Yo-EL;
        Wed, 11 Oct 2023 20:12:01 -0300
Date:   Wed, 11 Oct 2023 20:12:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@linux.dev>,
        Leon Romanovsky <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Message-ID: <20231011231201.GH55194@ziepe.ca>
References: <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
 <OS3PR01MB9865F9BEB1A90DDCAEEBFC8BE5CDA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20231010160919.GC55194@ziepe.ca>
 <a4808fa6-5bd5-4a64-a437-6a7e89ca7e9f@acm.org>
 <20231011155104.GF55194@ziepe.ca>
 <70191324-018e-4cfe-9c1d-0bd3d17fb437@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70191324-018e-4cfe-9c1d-0bd3d17fb437@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 11, 2023 at 01:14:16PM -0700, Bart Van Assche wrote:
> On 10/11/23 08:51, Jason Gunthorpe wrote:
> > If we revert it then rxe will probably just stop development
> > entirely. Daisuke's ODP work will be blocked and if Bob was able to
> > fix it he would have done so already. Which mean's Bobs ongoing work
> > is lost too.
> 
> If Daisuke's work depends on the RXE changes then Daisuke may decide
> to help with the RXE changes.
> 
> Introducing regressions while refactoring code is not acceptable.

Generally, but I don't view rxe as a production part of the kernel so
I prefer to give time to resolve it.

> I don't have enough spare time to help with the RXE driver.

Nor I

Jason
