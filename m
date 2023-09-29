Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1497B3AD1
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 21:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjI2T40 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjI2T40 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 15:56:26 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458E11B1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 12:56:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690d9cda925so11772062b3a.3
        for <linux-rdma@vger.kernel.org>; Fri, 29 Sep 2023 12:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696017384; x=1696622184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a819MkWwG+HUW3DecPflS1GgW7AmRacZ2O8fhQTbwAc=;
        b=dG8t6WDicmZpz6llDpNvlOD74K/eKRxsAGor2GpbtoofGpWQTCYvmYxLyymuh/Hmeo
         ZOelb+e/SCk3pXGB4sOOfptG/xCMaqEZgxQi1JCtjDnzTpdpbW3wxn9MheEh0Q9pJE6a
         7HIC4dNe01A9B3EIsOwm+BbQzOHEpQvB5f/HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696017384; x=1696622184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a819MkWwG+HUW3DecPflS1GgW7AmRacZ2O8fhQTbwAc=;
        b=XwaY2jWzURc1aFKRdbQGsvrJab4GIKy3YWLLISr3+MDZbdTuLpG/MZhabUJyz4+BQD
         o/yIg24H+SNvalyewt3fN0BlSnhvUbSMvaw+wrVABDCGrhWOvW/NHsEKMuN/03J3GlQe
         fc2sA2XsxyAMad/rEdgkLIdXu94LUeJgA3NWWuMsJLrLBOq6G6jsQDO4LH3ZPVm3GGo8
         ZkT5OQ4virw454tVMGRSmnAX0j8M+9GC5KViAxaTsNqxrDL4d6TN7nNIGx8lA/4LFe+O
         pk4tU6K6PkPBTamVrKXAkZGwrdrueKO3ILYPXtkkL0nt8fCx4JJRRKli9gD50L9unqJv
         KuRw==
X-Gm-Message-State: AOJu0YwA7T9ohSLqFraXEH2yDJD4cCxCJQSrxWG02gGI3wP7EhyHo/t7
        6N35dzek7zs+osdSjgBgZhnPYg==
X-Google-Smtp-Source: AGHT+IFmcOfiSdELEbLKd8ox6gsbRf6j5QyiZQ7r3SFlnve7gNT6GccQbgqvYKzrz4AZ0fNlmdapnQ==
X-Received: by 2002:a05:6a00:1951:b0:68f:dd50:aef8 with SMTP id s17-20020a056a00195100b0068fdd50aef8mr5166207pfk.4.1696017383659;
        Fri, 29 Sep 2023 12:56:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x9-20020a056a00270900b00690fdeb5c07sm15830854pfv.13.2023.09.29.12.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:56:22 -0700 (PDT)
Date:   Fri, 29 Sep 2023 12:56:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dean Luick <dean.luick@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Justin Stitt <justinstitt@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: replace deprecated strncpy
Message-ID: <202309291255.C5485E6811@keescook>
References: <20230921-strncpy-drivers-infiniband-hw-hfi1-chip-c-v1-1-37afcf4964d9@google.com>
 <169537858725.3339131.15264681410291677148.b4-ty@kernel.org>
 <2f4bd46c-664e-4253-8d57-16bd46dd3be8@cornelisnetworks.com>
 <202309232019.BE78A9C0@keescook>
 <a3b6e914-7469-42d7-81c8-9775715b263e@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3b6e914-7469-42d7-81c8-9775715b263e@cornelisnetworks.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 26, 2023 at 07:56:34AM -0500, Dean Luick wrote:
> On 9/23/2023 10:20 PM, Kees Cook wrote:
> > On Fri, Sep 22, 2023 at 09:25:39AM -0500, Dean Luick wrote:
> >> On 9/22/2023 5:29 AM, Leon Romanovsky wrote:
> >>>
> >>> On Thu, 21 Sep 2023 07:17:47 +0000, Justin Stitt wrote:
> >>>> `strncpy` is deprecated for use on NUL-terminated destination strings
> >>>> [1] and as such we should prefer more robust and less ambiguous string
> >>>> interfaces.
> >>>>
> >>>> We see that `buf` is expected to be NUL-terminated based on it's use
> >>>> within a trace event wherein `is_misc_err_name` and `is_various_name`
> >>>> map to `is_name` through `is_table`:
> >>>> | TRACE_EVENT(hfi1_interrupt,
> >>>> |        TP_PROTO(struct hfi1_devdata *dd, const struct is_table *is_entry,
> >>>> |                 int src),
> >>>> |        TP_ARGS(dd, is_entry, src),
> >>>> |        TP_STRUCT__entry(DD_DEV_ENTRY(dd)
> >>>> |                         __array(char, buf, 64)
> >>>> |                         __field(int, src)
> >>>> |                         ),
> >>>> |        TP_fast_assign(DD_DEV_ASSIGN(dd);
> >>>> |                       is_entry->is_name(__entry->buf, 64,
> >>>> |                                         src - is_entry->start);
> >>>> |                       __entry->src = src;
> >>>> |                       ),
> >>>> |        TP_printk("[%s] source: %s [%d]", __get_str(dev), __entry->buf,
> >>>> |                  __entry->src)
> >>>> | );
> >>>>
> >>>> [...]
> >>>
> >>> Applied, thanks!
> >>
> >> It is unfortunate that this and the qib patch was accepted so quickly.  The replacement is functionally correct.  However, I was going to suggest using strscpy() since the return value is never looked at and all use cases only require a NUL-terminated string.  Padding is not needed.
> >
> > Is the trace buffer already guaranteed to be zeroed? Since this is
> > defined as a fixed-size string in the buffer, it made sense to me to be
> > sure that the unused bytes were 0 before copying them to userspace.
> 
> I was not aware that binary trace records were exposed to user space.  If so, and the event records are not zeroed (either the buffer as a whole, or individual records), then strscpy_pad() is the correct solution.  My quick review of the tracing system suggests that nothing is zeroed and the record is embedded in a larger structure.  However, this begs the question for all users of tracing: Aren't alignment holes in the fast assign record a leak?

I thought they were passed over direct to userspace somehow, but I
haven't looked at the details in a long time. I could very well be
misunderstanding it.

-- 
Kees Cook
