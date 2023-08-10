Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4700F777EA3
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Aug 2023 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjHJQxN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Aug 2023 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJQxN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Aug 2023 12:53:13 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925A1728
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 09:53:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc83a96067so8626355ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691686392; x=1692291192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RNX9RZiB9L23oxeNDCtjH+614RITUrM5WpshdQGdNHw=;
        b=FsIklyiyyD4hcdtdtP3AWLGW8dAgAX6E/NCxDnbnjSblyP+6PQfUZtGcpimkILtqpI
         iJ09rZ2KjcIcICSEv8RSfKkA1PyD7GpC4w/FpjWl2my/ZdfHnSfVgrR7e9tAKQyHgCqm
         JW5g9N52S8MHnm2EfNfbdIntKrbbbF7/MX++3yAK0dJXSYuPIPV1xOaVGfVjE2pdhNRj
         Z346BzFeYPbfijblyYMQ/bCahGbTRa5oNW2IcKWa9rlZ/XklGnk+VNaUnXwGWqHSQ3l5
         lL/ZEle2JJzn2I8YsrLxfKIStADbhORBReQkTmgnLcviIHtOkXfD4mD+C41NzFzOpHNH
         KnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691686392; x=1692291192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNX9RZiB9L23oxeNDCtjH+614RITUrM5WpshdQGdNHw=;
        b=IIJTPCTR3Ptj8gB+7xtnfIfEDkoeyRcV57nJTlC71N1YGdBwfylpfyh9k38nSX6T4h
         jGOLHteQUuUViJ07efr5aofRD2u8+lT4E9KDtN4DuwK9amED5CWzWWjTbkzFmRdubDVp
         Ynz0jLd2InebKb3wHDVH5FD7pFRLPunJpL9eZogx/Nh+SzpGPAry0va0Rvb7YRkjZ7iU
         fi1zNKT1lfk9kYXaoXSWkXmDxcrR0TQZZffXckNyZztsHTCbWH/SjPap4SwW9WmKGDzW
         F9TBjwMvqhpbirespk3uJkpvBZhrOiQD5sswJ08twe6C0ix5BaFu853yAXxBBCeANJOw
         A8LQ==
X-Gm-Message-State: AOJu0YxEaSXMQR9vIlGh48xioeyaS6BrR72uhe0qVuJR1/0ZTbu5/V2R
        pRjGUSRDLCgtbm9c1eIM6/Q0BDQgkfrha5MHRuw=
X-Google-Smtp-Source: AGHT+IFfpH9qdWT9t0/Os+RcyqPR1mA+RaWZaL1Cy1iQLGMzjq8BicSa+nHCF26mtCXpmOaIgxpMPw==
X-Received: by 2002:a17:903:644:b0:1bc:54b8:41f6 with SMTP id kh4-20020a170903064400b001bc54b841f6mr2288504plb.52.1691686392078;
        Thu, 10 Aug 2023 09:53:12 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id x15-20020a1709027c0f00b001b9ecee9f81sm2015840pll.129.2023.08.10.09.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:53:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qU8uM-005HAC-4m;
        Thu, 10 Aug 2023 13:53:10 -0300
Date:   Thu, 10 Aug 2023 13:53:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: When should positive and negative error codes be used?
Message-ID: <ZNUV9trKmqggwHPh@ziepe.ca>
References: <f6aeac31-89a5-1eeb-11a5-2eb545de116d@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6aeac31-89a5-1eeb-11a5-2eb545de116d@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 10, 2023 at 02:51:37PM +0800, Junxian Huang wrote:
> Hi all!
> 
> I'm wondering if there is a clear rule for the usage of positive and
> negative values of error codes.
> 
> It seems that negative values are uniformly used in kernel space, but
> both positive and negative values are used in user space. When should
> positive values be used and when should negative values be used?

We always use negative in the kernel

Userspace is supposed to set errno and often return positive err codes
But we have not done a good job there

Jason
