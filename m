Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390756C7FFE
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Mar 2023 15:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjCXOhi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Mar 2023 10:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjCXOhf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Mar 2023 10:37:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BB822780
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 07:37:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id le6so1946848plb.12
        for <linux-rdma@vger.kernel.org>; Fri, 24 Mar 2023 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679668648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zkubb4rSCkv5+MXawObpi0wBZwFawLxkL6C8Ao6JjI=;
        b=MeNuWFCA6pwLsCXbi6rMfv8OdKoonrgdJu/gFnnHJoXQ4yLJV9OAzn2gmTOikBmHSv
         nYyLyJ2K4s2+2hgaPVsl6Mq4Pu1kw0WNM1EzpUySQDY2vEmUMyGKldZl4BOAiXPE/GT6
         +WDoiRvDZoJjjCXfl+cHeqRTnuXb3PdQj17Fa1lzZhaJLG7lNBmVUO5gAY/JIzPlOlSt
         +kHsHnIuT/ug25LjfwveNLDzBqa50/k2Eya3RG1qC3sMsy/Y1tAcKNbFUJcvGfZsXSaY
         heKNFkAqrHeeAfBi1Mon3Mu+6trKsT1/v7dWT1m9IkPvQYGX4s1J782WMT+mHwAwpXIf
         OsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679668648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zkubb4rSCkv5+MXawObpi0wBZwFawLxkL6C8Ao6JjI=;
        b=3y4XSD/3DNfCaGSGai/IOopMeDUwgmUuifYy/RSOLoyremtrbnF3EKsXw8XFJ8Bx6X
         TIKcdWatu90HOlO2+yYawKF4w4U1WTGLpkX939kDMZfIrtbNI9mpaxU/kUtWLyOA+knB
         ZJU4Lyv1e02CIkOnBFZ+1j8R+CcsZAg0NlOEPkN6TuyU/t5VdBvserPjNQiirvykroVP
         mRHGZMM1ex1/P5aaQctH2XeiIYCz9FxWJ42hqzc4KLOqu0xqUIlAr7oDxDJIM/EwpGHk
         xuZY7WMC5MiBpSsW1JMm1yPfAJiwc30WH5ZsD+2Yv+ZaWIXBFfAMRjjBphPbZ75kJmfP
         tOsA==
X-Gm-Message-State: AAQBX9f6Co4l6GiaDMZ0VoR75LP7u5YtvwzHEQuAG0p8TwdT1kUHzFn6
        Y5NPI40UJOCBcEOM1iBcyrDh6w==
X-Google-Smtp-Source: AKy350Y0KDZkBh55HZDQ5amuWyxObEGGFTwOIqEcHniLR6ROU4A68lz/62Fp+I/RBuzWdKXD3YFE6Q==
X-Received: by 2002:a17:903:1246:b0:1a0:6721:c0fa with SMTP id u6-20020a170903124600b001a06721c0famr3690141plh.25.1679668648334;
        Fri, 24 Mar 2023 07:37:28 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902760900b001a1a8e98e93sm13993846pll.287.2023.03.24.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 07:37:27 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pfiXm-0020h9-8X;
        Fri, 24 Mar 2023 11:37:26 -0300
Date:   Fri, 24 Mar 2023 11:37:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Cc:     leon@kernel.org, selvin.xavier@broadcom.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/core: Fix GID entry ref leak when create_ah
 fails
Message-ID: <ZB21phfIzgJlTlYk@ziepe.ca>
References: <20230323052140.143843-1-saravanan.vajravel@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323052140.143843-1-saravanan.vajravel@broadcom.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 22, 2023 at 10:21:40PM -0700, Saravanan Vajravel wrote:
> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.

I have to throw out patches that have these trailers, please fix your
mailer

Jason


