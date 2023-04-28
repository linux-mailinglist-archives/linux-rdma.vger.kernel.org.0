Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884EB6F19E9
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Apr 2023 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346308AbjD1Nrl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Apr 2023 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346217AbjD1Nrk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Apr 2023 09:47:40 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E99E171E
        for <linux-rdma@vger.kernel.org>; Fri, 28 Apr 2023 06:47:39 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-74fb8677a36so280355785a.0
        for <linux-rdma@vger.kernel.org>; Fri, 28 Apr 2023 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1682689658; x=1685281658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqPNfVx26MQj/dMuYkTl831M4b4W22oDuuEzlBZ7FGo=;
        b=NHFJis7Ci8k1UBNxbRot/k1/RtYdm2T1qiXnLF4OoUzl49fNUjSS7EnzBO7r75GAHE
         a85Y70CfGPTfGKp9xVDwMbaxt3PXLUA29I7ek9urwSXaYw4XJ3/ia2pIqeGAx+nNyAAQ
         BrVhgxMBjihjpxSw65Rk63yNtm8cRyVCJwfvThQ9qdkuLgfz+sFAsAVy9Hkt9fNL3E3N
         Mz+v3eqGOYGcm4hMFXbd0I3IxEy3/mY728G0nuRyunhsb/BCce8fJmYxjHUDyoSxqtk5
         p2gpRMfFixBTEecLmBReFmF+LFultJ9ywfPlteymSOGALhEj+qLKPLMdEyV+KCW/gSiR
         r6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682689658; x=1685281658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqPNfVx26MQj/dMuYkTl831M4b4W22oDuuEzlBZ7FGo=;
        b=SHCtTo7c/dxM5C27K08rjaXHvGCPn8O1vanWvAgeoUQZsxf82iCXQb0e6KwXzL5ahZ
         Mbh11f5FHnprRyZzt2bE667ZHE8oOfzJcvI/qbF4wO7KHR0zzNB57mTSVIgZyixPdyDu
         i2G755uqeBeUEdYKmEB2lxWsj7cjkjwqv9lnlI4NhNGRBQQ98zQLFLJzzbNFsw0HCmzU
         OUv73znOBsP7nxJF2LlRyiPgUl2UM5SgNNjKmAIuoR3101oCcDesSHS0dFP7cjzpq0gD
         tX0MRqXbCh4o/H4Z/BIul0IAJHoXiKIbtjcN7HlxhWxF+i0eaG5RkT7KY/ehKUYEI63r
         mp/Q==
X-Gm-Message-State: AC+VfDwescWN7SQINr0aaBPzBEVCo0nN+okNv98ab76PZQaVjDX9rDXy
        oVD8d5GnpaTIeZtF2VAHF8Exkg==
X-Google-Smtp-Source: ACHHUZ4CWkyIGX6bpvoP71nXeehZzVBpYL3HbSLWAm+1TxSW8Bs/4EqkD5e2SdZJXOJKvJ8VzYe+Wg==
X-Received: by 2002:ac8:4e41:0:b0:3f2:626:9c3 with SMTP id e1-20020ac84e41000000b003f2062609c3mr3275151qtw.36.1682689658719;
        Fri, 28 Apr 2023 06:47:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x1-20020ac81201000000b003e69c51cf53sm7054187qti.72.2023.04.28.06.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 06:47:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1psORl-003CLs-K9;
        Fri, 28 Apr 2023 10:47:37 -0300
Date:   Fri, 28 Apr 2023 10:47:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Chuck Lever <cel@kernel.org>, Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC] RDMA/core: Store zero GIDs in some cases
Message-ID: <ZEvOec75yMrin/hB@ziepe.ca>
References: <168261567323.5727.12145565111706096503.stgit@oracle-102.nfsv4bat.org>
 <ZEvMo4qkj9NSLXTA@ziepe.ca>
 <34E28C03-5D1A-4DAA-9B5B-D453F8C256BD@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34E28C03-5D1A-4DAA-9B5B-D453F8C256BD@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 28, 2023 at 01:42:24PM +0000, Chuck Lever III wrote:
> 
> 
> > On Apr 28, 2023, at 9:39 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Thu, Apr 27, 2023 at 01:14:43PM -0400, Chuck Lever wrote:
> >> From: Bernard Metzler <bmt@zurich.ibm.com>
> >> 
> >> Tunnel devices have zero GIDs, so skip the zero GID check when
> >> setting up soft iWARP over a tunnel device.
> > 
> > Huh? Why? How does that make any sense?
> 
> Read it as a cry for help.
> 
> The scenario is attempting to set up a soft iWARP device
> with a slave that is a tunnel device. The set up seems to
> work, but when connecting, the ULP gets an ADDR_ERROR
> because the setup did not add an entry to the GID table.

Don't assign a 0 IP to the tunnel?

Jason
