Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3114B125A67
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 06:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfLSFG6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 00:06:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43913 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfLSFG6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Dec 2019 00:06:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so5532877oth.10
        for <linux-rdma@vger.kernel.org>; Wed, 18 Dec 2019 21:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rb2W8g1AEUcUpdiCjOYZK51H7XIWrVIYw9RXrqsDNVI=;
        b=frSF6CrCt7jFnAVgKb08xB5sojZ5z1YUvwUUREPv/bvCEZ4S78S2IjS2kD/KkhNxE1
         pSwqeQvHq9IzKqJp71wOgdoFEoixSsFRVql2z4vE062uo7p2jJiZngtpm0z0WF7lsF9j
         t57Wgc9ksS0fLnHRoKWEoOK4FYyWu26knMIn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rb2W8g1AEUcUpdiCjOYZK51H7XIWrVIYw9RXrqsDNVI=;
        b=PfH2NSpv7YCqlf86a2eYapakFsHjMwvlZeGBHb6BHhQWEl8MKbJRJ9gYvZVyPhFQJG
         VWmZsQ4sXPfPKVHTB3R9laEPrqE4xKLuj93fROduYwCvsUH4krcu4SLtlof63BYmFt38
         EWhlSjiClOPNptMAWnsKVaZmIF8ZFJyNjhDC9B2YHMdiwTp7esoP8LnGb4VvJ5irMM59
         nVx9Q4sMrY1H+Q6N+eBoxFeiPVAz+a32s9s0fn5M+k+MmWMFY7WMUHF8m308XPMIfQZH
         KDcu3OkIKVDGCcp0hv1bj2IFq0dXlJ/oaR2b29zm6dQo/WpghImgUVEnjr9o0I4IfF6V
         l05Q==
X-Gm-Message-State: APjAAAX0MGgA72lVpZX6n1GL0Ra1diVJo1OKkfSC+kCCksn+3V2LCYsX
        OOpQrYKwaTCzmE7LU+DPRJ7VPcki5X9IH1KPEnlnHqPrRFBRqA==
X-Google-Smtp-Source: APXvYqxo/CTBsrJcxBOv107PUo2qEqmbLRCUnoWQH0uBfjFANwACu6TFGqkom8sypgpUv105DpW++9pqw2U8I0tsxL8=
X-Received: by 2002:a05:6830:1bd5:: with SMTP id v21mr7142449ota.154.1576732016925;
 Wed, 18 Dec 2019 21:06:56 -0800 (PST)
MIME-Version: 1.0
References: <1576477201-2842-1-git-send-email-selvin.xavier@broadcom.com>
 <1576477201-2842-2-git-send-email-selvin.xavier@broadcom.com>
 <20191218140835.GG17227@ziepe.ca> <903a4154-8237-0178-dc5f-34c58fa06aaa@mellanox.com>
In-Reply-To: <903a4154-8237-0178-dc5f-34c58fa06aaa@mellanox.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Thu, 19 Dec 2019 10:36:45 +0530
Message-ID: <CA+sbYW2nvT09ty8FsbG=GC_3MWJLJU8Mh_Lq+96ffvdxnfFr_Q@mail.gmail.com>
Subject: Re: [PATCH for-next v2 1/2] IB/core: Add option to retrieve driver
 gid context from ib_gid_attr
To:     Parav Pandit <parav@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 19, 2019 at 7:52 AM Parav Pandit <parav@mellanox.com> wrote:
>
> On 12/18/2019 7:38 PM, Jason Gunthorpe wrote:
> > On Sun, Dec 15, 2019 at 10:20:00PM -0800, Selvin Xavier wrote:
> >> Provide an option to retrieve the driver gid context from ib_gid_attr
> >> structure. Introduce ib_gid_attr_info structure which include both
> >> gid_attr and the GID's HW context. Replace the attr and context
> >> members of ib_gid_table_entry with the new ib_gid_attr_info
> >> structure. Vendor drivers can refer to its own HW gid context
> >> using the container_of macro.
> >
> > This seems really weird. Why are we adding a new struct instead of
> > adding context to the normal gid_attr, or adding some
> > 'get_ib_attr_priv' call?
>
> Rest of the stack didn't need to touch context, so it is added only as
> vendor driver facing container_of().
Added the new structure since I didn't want to move the private structure
ib_gid_table_entry to a header file.
>
> Instead I guess a new symbol as rdma_get_gid_attr_context() can be added
> too.
I am okay with both adding context to gid_attr struct or adding a symbol.
Let me know your preference.
Or shall i handle this inside bnxt_re itself. Not sure whether any
other drivers intend to use this.
