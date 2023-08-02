Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD876C133
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Aug 2023 01:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjHAXqH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Aug 2023 19:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHAXqG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Aug 2023 19:46:06 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDBE1B1
        for <linux-rdma@vger.kernel.org>; Tue,  1 Aug 2023 16:46:05 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76ca7b4782cso212261485a.0
        for <linux-rdma@vger.kernel.org>; Tue, 01 Aug 2023 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690933565; x=1691538365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBKGP+rOQrE0yI33WFL70QQXfWqUPCJII6/ruXV7a18=;
        b=SWXVXrgm7uYZHZpxzUnYKGRlHWgX0IK0Rnlpt7cDr5IAkGjYP2UkjUfjYQGOZNR6qJ
         LJgCwO55lyoYtyX6E3Q4s40xhlJi1dKPH0AZpIy8isp0s8rC0ju8u3sjUbibjy6jNmr+
         mcJOcMWuV5sswR+4lXv+R2JNNPJMLL1UAxV+nc9eXFABT8+j+4Fr4O92HGXMdw8ZW/cO
         tYSdLgE9sYsL2LpWr9Lpjtw96tubbaY6Lk9BRgEa7XCIyKeCZkvIgI1OH2+pWauTOwMU
         tjTG/lngwIPwA8M8k3ptItHteXjaC4SjLv7Eqa1WLuIH7QiFLFw+WP+vp7HZAj1aZd8b
         Tmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690933565; x=1691538365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBKGP+rOQrE0yI33WFL70QQXfWqUPCJII6/ruXV7a18=;
        b=hnr9QlTn1zqLR83R+bwoGSDOokwfXnpNB9yPlG36g+pnZ1ToiwgqRK4Dyu5kb5SM72
         uz8YuRS7729WwtBfVGXMf6NiXZTrGvD4oO7kgonBa5yI2QHP/aDwIy6RRqDd5wCuuzKh
         J/FVkRIzUwswDFRNzTFfRK3H9EbYCwDHnvFUCDbFT6lrgFCulaKHMx26w4SJR/IQx+y0
         vd6zoRURyV5w4QeHAmUew4o+o5FAsfacamASUxP2nBZro+Seo2ysRNQPJteFBQe+skqI
         HPiCD85I4+hCE2Ijf6KafcgaC4rvht8Q7KiNZVeX9oMQGkTleu7Gk8u1zY61OvxMK9h9
         bseA==
X-Gm-Message-State: ABy/qLZ0CikvxdnkYwXwc9suGJvZQLKzluqnTy/tP32U2sqdFGqD+Wk9
        SkzFjQ0TZwvzrM94Gdt+VD/LTg==
X-Google-Smtp-Source: APBJJlGxnpoNiNKnO6qXw0UeYYlZ6fEaFr61aQgxxSleH8rfkxM6Fg0dXraa5FyNSubaYwh/wMlyfw==
X-Received: by 2002:a05:620a:4010:b0:76c:bf54:70ab with SMTP id h16-20020a05620a401000b0076cbf5470abmr5499429qko.12.1690933564773;
        Tue, 01 Aug 2023 16:46:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id q10-20020ae9e40a000000b007676f3859fasm4543814qkc.30.2023.08.01.16.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:46:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qQz3z-002y3w-GJ;
        Tue, 01 Aug 2023 20:46:03 -0300
Date:   Tue, 1 Aug 2023 20:46:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Long Li <longli@microsoft.com>
Cc:     Wei Hu <weh@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>
Subject: Re: [PATCH v4 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Message-ID: <ZMmZO9IPmXNEB49t@ziepe.ca>
References: <20230728170749.1888588-1-weh@microsoft.com>
 <ZMP+MH7f/Vk9/J0b@ziepe.ca>
 <PH7PR21MB3263C134979B17F1C53D3E8DCE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQCuQU+b/Ai9HcU@ziepe.ca>
 <PH7PR21MB326396D1782613FE406F616ACE06A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <ZMQLW4elDj0vV1ld@ziepe.ca>
 <PH7PR21MB326367A455B78A1F230C5C34CE0AA@PH7PR21MB3263.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB326367A455B78A1F230C5C34CE0AA@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 01, 2023 at 07:06:57PM +0000, Long Li wrote:

> The driver interrupt code limits the CPU processing time of each EQ
> by reading a small batch of EQEs in this interrupt. It guarantees
> all the EQs are checked on this CPU, and limits the interrupt
> processing time for any given EQ. In this way, a bad EQ (which is
> stormed by a bad user doing unreasonable re-arming on the CQ) can't
> storm other EQs on this CPU.

Of course it can, the bad use just creates a million EQs and pushes a
bit of work through them constantly. How is that really any different
from pushing more EQEs into a single EQ?

And how does your EQ multiplexing work anyhow? Do you poll every EQ on
every interrupt? That itself is a DOS vector.

Jason
