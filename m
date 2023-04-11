Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC46DE173
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Apr 2023 18:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDKQty (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Apr 2023 12:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjDKQtt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Apr 2023 12:49:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8BCE5E
        for <linux-rdma@vger.kernel.org>; Tue, 11 Apr 2023 09:49:48 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51aac8f68cdso90671a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 11 Apr 2023 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1681231788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKM/Au7LCIa72XM+Je2Si+gvd0HziYllwF6Cjpb4PW8=;
        b=hC9E32DRv7+pS1N6/5j+hRh+3GNBj12qEbIu5CBChxbihc1mcVdcB3o23NOHq3WqVK
         Q3+eJ8iiHJZiRaFUPl/ACzYB1d1ylldWdHZOg3XCk1iKQEJmurjpMn1N4fi8i7Z4iI9O
         PDl5gQBYAP63BIM7P4TeNO6uHdN4yP90zfboEjHaib4J5FpvDaJWhv2rmBL7rGpJzOBo
         hG5djZsQaRyAny935yx0c/KO0RANRZ8AtFXJy1Om7UbSIxgIHBcN4/idw5lGutuAtSQq
         jwH7sxOmPJI+BA8XAeKlLzAVVgVxPXQ4jVZGc+3WA3X1Uz2G6LLytRScMlQk3aeFbpSg
         4HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681231788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKM/Au7LCIa72XM+Je2Si+gvd0HziYllwF6Cjpb4PW8=;
        b=LwzKnS6A/XMlaxD2YFNItZfUblAmCzUCknQUQdfswta/nvWBsqLDdrX1gNt0dlTZOJ
         a96I9Sk99Ly//u0U/9cTbTS579sg8q9hhvX63qeqKT/EChLg1eD6hkr+vblYZsw2sTeB
         3EgZgiZPAhCVfuSBui8ocUmVF3Av6ZsioV4nEUiYX0zO6PdI0idSVHEqbpnayO26ZRn3
         mSt0WWvV59cCFVrJmC835LWn5fk8hw8f9lHzK7PIMyBF16wSp8F0tBgRuHuSFAqnvNxl
         pj5JSOfJndMBLYKRW8ux794hwloCQ4oyUOdZinadklH3AtM+nJdC8RGlDacpoe1Y6Cgg
         apcA==
X-Gm-Message-State: AAQBX9ckD1s3XhzzNzz+LqsDXXwIgUmqVZx/g4m/OHmzHVBtyUs7cRN6
        8oRDVPFxq1eToSUu421w2wnnmw==
X-Google-Smtp-Source: AKy350bJLjPUo8R4b3qITkC/Ivl06N6uJsPpV6H3CXIECCLKzbXY7TcJ8REBG5bcNaoXUB+YOKRWJw==
X-Received: by 2002:aa7:96ba:0:b0:63a:fb40:891a with SMTP id g26-20020aa796ba000000b0063afb40891amr648726pfk.2.1681231787969;
        Tue, 11 Apr 2023 09:49:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id a20-20020a62bd14000000b00625f5aaa1d9sm10007903pff.83.2023.04.11.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:49:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pmHBh-009Phv-H1;
        Tue, 11 Apr 2023 13:49:45 -0300
Date:   Tue, 11 Apr 2023 13:49:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next 2/6] RDMA/bnxt_re: Add disassociate ucontext
 support
Message-ID: <ZDWPqXhlkhMKXv04@ziepe.ca>
References: <1681125115-7127-1-git-send-email-selvin.xavier@broadcom.com>
 <1681125115-7127-3-git-send-email-selvin.xavier@broadcom.com>
 <20230410122701.GQ182481@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410122701.GQ182481@unreal>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 03:27:01PM +0300, Leon Romanovsky wrote:
> On Mon, Apr 10, 2023 at 04:11:51AM -0700, Selvin Xavier wrote:
> > Add empty stub for disassociate ucontext as done in other vendor
> > drivers.
> 
> It will be great to mention in commit message that the reason to this
> stub is because you use rdma_user_mmap_io().

That isn't the reason to do this stub..

It is some yet-to-be-cleaned-up way for the driver to indicate it
*fully* supports driver disassociation.

rdma_user_mmap_io() is part of that support, but the whole
functionality should be tested before setting this.

Jason
