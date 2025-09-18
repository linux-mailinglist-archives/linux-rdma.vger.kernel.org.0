Return-Path: <linux-rdma+bounces-13476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115DCB83F09
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE1F7A8166
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E12E9743;
	Thu, 18 Sep 2025 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6mng8FS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C4221DAE;
	Thu, 18 Sep 2025 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189530; cv=none; b=aVlva4lHd0RTRaztnKx10ZRVCqStAMi07WkbVD3k0iwaz1g3TiQdnga+hU4jFt9Wu4Ai6JjO6EmVaIYCwrdieRtA8zONfeAfNASU8+S8h/Vjkcu80H2Xko0pFQOK+h9N9QcOHzztNHEkybl+I1+R2b/GbrYPFdozAYb3iXlQKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189530; c=relaxed/simple;
	bh=wZ0jJ3AfFbctD9TGyyfz/skh1/gN9TayJVlnjwK+8xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve50ffaLNfO7KFgREDvoLMIkddzMpTE35fOvw5e0f5O+m22kw/+7tAKq1yQStqpSBVUMLZpPm/4F/LwWzq2szx0Q/3IfxUfDmB4do0SrmYizqJV1Tfli3GAipW+OMvfprtnJyYV45Uq/SeUrO0/TfC3sfPP1slzoU0Ja9RWETTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6mng8FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B261C4CEE7;
	Thu, 18 Sep 2025 09:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758189530;
	bh=wZ0jJ3AfFbctD9TGyyfz/skh1/gN9TayJVlnjwK+8xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6mng8FS7mZ813mxW/F0Y3qsrI0aKGcwjPAFxKqnv2H7du7w2FzK7FCOOdLzwdpz1
	 LwkpL0HlFOBpk39auPasGutwiX/ek9UUQFF0F0zlmZFy1B7KJ4aYIjyQBb66bIgfrh
	 GPYvLhVQ7Pf+aeuO7MOrJp9lRtdleQ/HCOncFVjW+DdJrzADlGfPjaZXlktow+jSwT
	 emgQF4QxcHq3So6p63+VHfWSkjmt+b8Qw0up2pSfJa3XZl49oZWc62UixrNt7tqoPX
	 5CYsjDIdfrM8+8D8BLey76pRwjI35wuCIXrL9WV8yIJBnOs0/cCmf9ZpCr+2gYi2Ya
	 a3YB4dOTGoCvg==
Date: Thu, 18 Sep 2025 12:58:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: Gui-Dong Han <hanguidong02@gmail.com>, zyjzyj2000@gmail.com,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix race in do_task() when draining
Message-ID: <20250918095844.GD10800@unreal>
References: <20250917100657.1535424-1-hanguidong02@gmail.com>
 <a321729d-f8a1-4901-ae9d-f08339b5093b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a321729d-f8a1-4901-ae9d-f08339b5093b@linux.dev>

On Wed, Sep 17, 2025 at 12:30:56PM -0700, yanjun.zhu wrote:
> On 9/17/25 3:06 AM, Gui-Dong Han wrote:
> > When do_task() exhausts its RXE_MAX_ITERATIONS budget, it unconditionally
> 
> From the source code, it will check ret value, then set it to
> TASK_STATE_IDLE, not unconditionally.
> 
> > sets the task state to TASK_STATE_IDLE to reschedule. This overwrites
> > the TASK_STATE_DRAINING state that may have been concurrently set by
> > rxe_cleanup_task() or rxe_disable_task().
> 
> From the source code, there is a spin lock to protect the state. It will not
> make race condition.
> 
> > 
> > This race condition breaks the cleanup and disable logic, which expects
> > the task to stop processing new work. The cleanup code may proceed while
> > do_task() reschedules itself, leading to a potential use-after-free.
> > 
> 
> Can you post the call trace when this problem occurred?
> 
> Hi, Jason && Leon
> 
> Please comment on this problem.

The idea to recheck task->state looks correct to me, otherwise we overwrite it unconditionally.
However I would write this patch slightly different (without cont = 1):

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 6f8f353e95838..2ff5d7cc0a933 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -132,8 +132,10 @@ static void do_task(struct rxe_task *task)
                 * yield the cpu and reschedule the task
                 */
                if (!ret) {
-                       task->state = TASK_STATE_IDLE;
-                       resched = 1;
+                       if (task->state != TASK_STATE_DRAINING) {
+                               task->state = TASK_STATE_IDLE;
+                               resched = 1;
+                       }
                        goto exit;
                }

@@ -151,7 +153,6 @@ static void do_task(struct rxe_task *task)
                        break;

                case TASK_STATE_DRAINING:
-                       task->state = TASK_STATE_DRAINED;
                        break;

                default:
(END)



> 
> Thanks a lot.
> Yanjun.Zhu
> 
> > This bug was introduced during the migration from tasklets to workqueues,
> > where the special handling for the draining case was lost.
> > 
> > Fix this by restoring the original behavior. If the state is
> > TASK_STATE_DRAINING when iterations are exhausted, continue the loop by
> > setting cont to 1. This allows new iterations to finish the remaining
> > work and reach the switch statement, which properly transitions the
> > state to TASK_STATE_DRAINED and stops the task as intended.
> > 
> > Fixes: 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> > index 6f8f353e9583..f522820b950c 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_task.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> > @@ -132,8 +132,12 @@ static void do_task(struct rxe_task *task)
> >   		 * yield the cpu and reschedule the task
> >   		 */
> >   		if (!ret) {
> > -			task->state = TASK_STATE_IDLE;
> > -			resched = 1;
> > +			if (task->state != TASK_STATE_DRAINING) {
> > +				task->state = TASK_STATE_IDLE;
> > +				resched = 1;
> > +			} else {
> > +				cont = 1;
> > +			}
> >   			goto exit;
> >   		}
> 

