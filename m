Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A602A6D49DD
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Apr 2023 16:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbjDCOly (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Apr 2023 10:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjDCOlx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Apr 2023 10:41:53 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AED917AEB
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 07:41:52 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id hf2so28500004qtb.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 Apr 2023 07:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680532911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XCMHlErSfZ1Uo1a+gAkwbb9LwwkC70R107e77TKbGI=;
        b=F/DcPLZJb/wNWeuXEHdSIQmZISXLvlDNst4k8Pxb5phDZOBZG1p5oV9cM/K8lpkPxI
         oIEe7aplLZV1U0tvoVvNnWIKGP5jp03wrdSWXcSrJHra1CrId8dcy5Se3v27WKNA4K9c
         BFbDU9PNhYb7XsWPzD/jSikqMLTc1bPyBFz/AhKIZSyEBIqzyjS8QMNHdZuqm0oo0Jne
         bTWZVHpo9PmxoHeTdwhQ6UyhVSg2EQJy6HSitbQMW3L2vhoi+nSHRph9/EK26T7yzPEK
         BE9L6qm8tdybs9so3pTkYZyfN3HdWi7MlPRHfMTluonDbUdbHcT8VD7hU2AUkFkm5K4y
         Jagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680532911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XCMHlErSfZ1Uo1a+gAkwbb9LwwkC70R107e77TKbGI=;
        b=D4dQWX5SXV3q0GqsHbg9k4SMt1dWKLM6epLl0YYttENT5MBT/wovjZzyWdde2Ob49t
         ugA5eNbB9rNTZOo7gABl611VMS/6bgwCX1GmJ5XwOCCSkni48WNdr/OVd1cDxueZ+oCZ
         PTudflw7vKkKu/9WhtHBYv5xGq8uDGpwx9wrbrLxQXg66y43KsPqnjCtfnqLs/C5StdL
         rHNNaAXG0w3lQt7EXvWe9IFcPRiQovtBJ9Ykn+qukqolBmf36Yl+12cTnbAVntIU6Unj
         k5fQQX8bMOqM6pk6bAV4UcLsMiSIon7ggF+re5arDHBBeTpD1J/+WRnssEvf7+CihVCC
         Z3Sg==
X-Gm-Message-State: AAQBX9fqrS2Xb1fR6eIlxem+hW748UeD/2Avi1juIwzjlbcbfgPUj9Hq
        ELZG9RJCw6b6FopXWHXClT2Vde4UW+VX3J6Qe5o=
X-Google-Smtp-Source: AKy350YHfObX1C6S7ERoaQ9Tj6MtjkE7W4E3ISeLm7BOfwTTX4nAfUmki0AGkoigPqcCWxhZc0QeDw==
X-Received: by 2002:a05:622a:3:b0:3e6:5413:3bc7 with SMTP id x3-20020a05622a000300b003e654133bc7mr6069442qtw.30.1680532911113;
        Mon, 03 Apr 2023 07:41:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w25-20020a05620a129900b00742bc037f29sm2798637qki.120.2023.04.03.07.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:41:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pjLNV-006LtO-GS;
        Mon, 03 Apr 2023 11:41:49 -0300
Date:   Mon, 3 Apr 2023 11:41:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH for-rc] RDMA/srpt: Add a check for valid 'mad_agent'
 pointer
Message-ID: <ZCrlrSGisepZChKp@ziepe.ca>
References: <20230401063800.342432-1-saravanan.vajravel@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401063800.342432-1-saravanan.vajravel@broadcom.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 31, 2023 at 11:38:00PM -0700, Saravanan Vajravel wrote:
> When unregistering MAD agent, srpt module has a non-null check
> for 'mad_agent' pointer before invoking ib_unregister_mad_agent().
> This check can pass if 'mad_agent' variable holds an error value.
> The 'mad_agent' can have an error value for a short window when
> srpt_add_one() and srpt_remove_one() is executed simultaneously.

Don't fix it like this, don't store err values in global pointers.

Jason
