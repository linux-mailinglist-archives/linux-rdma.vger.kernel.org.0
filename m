Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E662DDC85C
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 17:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410373AbfJRPW6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 11:22:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388554AbfJRPW5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 11:22:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2796C83F45;
        Fri, 18 Oct 2019 15:22:57 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99CE560603;
        Fri, 18 Oct 2019 15:22:56 +0000 (UTC)
Date:   Fri, 18 Oct 2019 23:22:53 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] srp_daemon: Use maximum initiator to target IU size
Message-ID: <20191018152253.GA32562@dhcp-128-227.nay.redhat.com>
References: <20191018044104.21353-1-honli@redhat.com>
 <1d811fc0-1f74-b546-b296-a4e9f8c33d86@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d811fc0-1f74-b546-b296-a4e9f8c33d86@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 18 Oct 2019 15:22:57 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 17, 2019 at 09:57:08PM -0700, Bart Van Assche wrote:
> On 2019-10-17 21:41, Honggang LI wrote:
> > +	if (config->print_max_it_iu_size) {
> > +		len += snprintf(target_config_str+len,
> > +				sizeof(target_config_str) - len,
> > +				",max_it_iu_size=%d",
> > +				be32toh(target->ioc_prof.send_size));
> > +
> > +		if (len >= sizeof(target_config_str)) {
> > +			pr_err("Target config string is too long, ignoring target\n");
> > +			closedir(dir);
> > +			return -1;
> > +		}
> > +	}
> 
> Hi Honggang,
> 
> I think this patch will make srp_daemon incompatible with versions of
                                          ^^^^^^^^^^^^

Yes, it compatible with old ib_srp kernel driver that do not support
the max_it_iu_size parameter. It will trigger a kernel message like
this:

ib_srp: unknown parameter or missing value 'max_it_iu_size=8276' in target creation request

But SRP login will continue and success.

> the ib_srp kernel driver that do not support the max_it_iu_size
> parameter and also that that's unacceptable. How about the following
> approach:
> * Do not add a new command-line option.

I suggest to use a new command-line, we can avoid the warning message by
remove the parameter from the srp_daemon commad.

> * Add max_it_iu_size at the end. I think that approach will trigger a

If we hard-code max_it_iu_size at the end, users with old srpt module
will not able to avoid the warn message. They have to use srp_daemon
without this patch.

thanks

> warning with older versions of the SRP kernel driver but also that it
> won't break SRP login.
> 
> Thanks,
> 
> Bart.
